import getpass
import math
import socket
from pathlib import Path
from typing import Any, Callable, Dict, List, Optional

from kittens.ssh.main import get_connection_data
from paramiko import SSHConfig

from kitty.boss import Boss
from kitty.fast_data_types import (
    Color,
    Screen,
    get_boss,
    get_options,
)
from kitty.tab_bar import (
    Dict,
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_title,
)
from kitty.utils import color_as_int
from kitty.window import Window

# Path to SSH config file (should be standard), needed to lookup host names and retrieve
# corresponding user names
SSH_CONFIG_FILE = "~/.ssh/config"

# Whether to add padding to title of tabs
PADDED_TABS = False

# Whether to draw a separator between tabs
DRAW_SOFT_SEP = True

# Whether to draw right-hand side status information inside of filled shapes
RHS_STATUS_FILLED = True

# Separators and status icons
LEFT_SEP = ""
RIGHT_SEP = ""
SOFT_SEP = "│"
PADDING = " "
BRANCH_ICON = "󰘬"
USER_ICON = ""
HOST_ICON = "󱡶"
PAGER_ICON = "󰦪"

# Colors
SOFT_SEP_COLOR = Color(89, 89, 89)
FILLED_ICON_BG_COLOR = Color(89, 89, 89)
ACCENTED_BG_COLOR = Color(30, 104, 199)
ACCENTED_ICON_BG_COLOR = Color(53, 132, 228)

MIN_TAB_LEN = (
    len(LEFT_SEP)
    + len(RIGHT_SEP)
    + len(PADDING) * 2 * PADDED_TABS  # separators
    + 1  # padding
    + 1
    + 1
    + 1
    + 1  # tab symbol, space, index number, space  # one title character
)


class Button:
    def __init__(self, first_cell: int, last_cell: int, action: Callable):
        self.first_cell = first_cell
        self.last_cell = last_cell
        self.action = action

    def do_action(self) -> None:
        self.action()


buttons: List[Button] = []


def _draw_element(
    title: DrawData | str,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    colors: Dict[str, int],
    filled: bool = False,
    padded: bool = False,
    accented: bool = False,
    icon: Optional[str] = None,
    soft_sep: Optional[str] = None,
) -> int:
    # When max_tab_length < MIN_TAB_LEN, we just draw an ellipsis, without separators or
    # anything else, so that it's clear that one either needs a larger max_tab_length,
    # or another tab bar design
    if max_tab_length < MIN_TAB_LEN:
        screen.draw("…".center(max_tab_length))
        return screen.cursor.x

    if accented:
        text_fg = colors["accented_fg"]
        text_bg = colors["accented_bg"]
        icon_bg = colors["accented_icon_bg"]
    elif filled:
        text_fg = colors["filled_fg"]
        text_bg = colors["filled_bg"]
        icon_bg = colors["filled_icon_bg"] if icon else colors["filled_bg"]
    else:
        text_fg = colors["fg"]
        text_bg = colors["bg"]
        icon_bg = colors["bg"]

    components = list()

    # Left separator
    components.append((LEFT_SEP, icon_bg, colors["bg"]))
    # Padding between left separator and rest of tab
    if padded:
        components.append((PADDING, text_fg, text_bg))
    # Icon, with padding on the right if there's a tab title, and more padding before
    # title if the tab is filled and there's a tab title
    if icon:
        icon_padding = PADDING if title != "" else ""
        components.append((f"{icon}{icon_padding}", text_fg, icon_bg))
        if filled and title != "":
            components.append((PADDING, text_fg, text_bg))
    # Title
    components.append((title, text_fg, text_bg))
    # Padding between tab content and right separator
    if padded:
        components.append((PADDING, text_fg, text_bg))
    # Right separator, which is drawn using the same colors as the left separator in
    # case there isn't a tab title
    right_sep_fg = text_bg if title != "" else icon_bg
    components.append((RIGHT_SEP, right_sep_fg, colors["bg"]))
    # Inter-tab soft separator
    if soft_sep:
        components.append((soft_sep, colors["soft_sep_fg"], colors["bg"]))

    for c in components:
        screen.cursor.fg = c[1]
        screen.cursor.bg = c[2]
        if isinstance(c[0], str):
            screen.draw(c[0])
        else:
            draw_title(c[0], screen, tab, index)
            max_cursor_x = before + max_tab_length - len(LEFT_SEP) - len(PADDING)
            if screen.cursor.x > max_cursor_x:
                screen.cursor.x = max_cursor_x - 1
                screen.draw("…")

    # Element ends before soft separator
    end = screen.cursor.x - (len(soft_sep) if soft_sep else 0)
    return end


def _calc_elements_len(elements: List[Dict[str, Any]]) -> int:
    elements_len = 0
    for element in elements:
        title, icon = element["title"], element["icon"]
        # Icon
        elements_len += len(icon)
        # Icon padding, if element has a title
        elements_len += len(PADDING) if title != "" else 0
        # Title
        elements_len += len(title)
        # Separators
        elements_len += 2
        if RHS_STATUS_FILLED:
            # Title padding, if element has a title
            elements_len += len(PADDING) if title != "" else 0
    # Inter-tab soft separators
    elements_len += len(elements) - 1
    return elements_len


def _is_running_pager(active_window: Window) -> bool:
    try:
        return Path(active_window.child.argv[0]).name == "nvim-pager.py"
    except:
        return False


def _get_system_info(active_window: Window) -> Dict[str, Any]:
    # Local info (and fallback for errors on remote info)
    user = getpass.getuser()
    host = socket.gethostname()
    is_ssh = False

    ssh_cmdline = []
    # The propery "child_is_remote" is True when the command being executed is a
    # standard "ssh" command, without using the SSH kitten
    if active_window.child_is_remote:
        procs = sorted(active_window.child.foreground_processes, key=lambda p: p["pid"])
        ssh_cmdline = procs[0]["cmdline"]
    # The command line is not an empty list in case we're running the ssh kitten
    else:
        ssh_cmdline = active_window.ssh_kitten_cmdline()

    if ssh_cmdline != []:
        is_ssh = True
        conn_data = get_connection_data(ssh_cmdline)
        if conn_data:
            conn_data_hostname = conn_data.hostname
            user_and_host = conn_data_hostname.split("@")
            # When only a host is specified on the command line, we try to lookup the
            # corresponding user in the SSH config file
            if len(user_and_host) == 1:
                host = user_and_host[0]
                config_fpath = str(Path(SSH_CONFIG_FILE).expanduser())
                host_config = SSHConfig.from_path(config_fpath).lookup(host)
                if "user" in host_config:
                    user = host_config["user"]
            # When the command line specifies both host and user, we just use these
            elif len(user_and_host) == 2:
                user, host = user_and_host
            else:
                print("Could not parse user and host name")
        else:
            print("Could not retrieve SSH connection data")

    return {"user": user, "host": host, "is_ssh": is_ssh}


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    """Draw tab.

    Args:
        draw_data (DrawData): Tab context.
        screen (Screen): Screen objects.
        tab (TabBarData): Tab bar context.
        before (int): Current cursor position, before drawing tab.
        max_tab_length (int): User-specified maximum length of tab.
        index (int): Tab index.
        is_last (bool): Whether this is the last tab to draw.
        extra_data (ExtraData): Additional context.

    Returns:
        int: Cursor positions after drawing current tab.
    """
 
    opts = get_options()
    colors = {}

    # Base foreground and background colors
    colors["fg"] = as_rgb(color_as_int(draw_data.inactive_fg))
    colors["bg"] = as_rgb(color_as_int(draw_data.default_bg))

    # Foreground, background and icon background colors for filled tabs
    colors["filled_fg"] = as_rgb(color_as_int(draw_data.active_fg))
    colors["filled_bg"] = as_rgb(color_as_int(draw_data.active_bg))
    colors["filled_icon_bg"] = as_rgb(color_as_int(FILLED_ICON_BG_COLOR))

    # Foreground, background and icon background colors for accented tabs
    colors["accented_fg"] = as_rgb(color_as_int(draw_data.active_fg))
    colors["accented_bg"] = as_rgb(color_as_int(ACCENTED_BG_COLOR))
    colors["accented_icon_bg"] = as_rgb(color_as_int(ACCENTED_ICON_BG_COLOR))

    # Inter-tab separator color
    colors["soft_sep_fg"] = as_rgb(color_as_int(SOFT_SEP_COLOR))

    soft_sep = None
    if DRAW_SOFT_SEP:
        if extra_data.next_tab:
            both_inactive = not tab.is_active and not extra_data.next_tab.is_active
            soft_sep = SOFT_SEP if both_inactive else PADDING

    # Draw main tabs
    end = _draw_element(
        draw_data,
        screen,
        tab,
        before,
        max_tab_length,
        index,
        colors,
        filled=tab.is_active,
        padded=PADDED_TABS,
        soft_sep=soft_sep,
    )

    # Draw right-hand side status
    if is_last:
        boss: Boss = get_boss()
        active_window = boss.active_window
        assert isinstance(active_window, Window)

        is_running_pager = _is_running_pager(active_window)
        sys_info = _get_system_info(active_window)
        user, host, is_ssh = sys_info["user"], sys_info["host"], sys_info["is_ssh"]

        elements = list()
        if is_running_pager:
            elements.append({"title": "", "icon": PAGER_ICON, "accented": True})
        elements.append({"title": user, "icon": USER_ICON, "accented": is_ssh})
        elements.append({"title": host, "icon": HOST_ICON, "accented": is_ssh})

        # Move cursor horizontally so that right-hand side status is right-aligned
        rhs_status_len = _calc_elements_len(elements)
        if opts.tab_bar_align == "center":
            screen.cursor.x = math.ceil(screen.columns / 2 + end / 2) - rhs_status_len
        else:  # opts.tab_bar_align == "left"
            screen.cursor.x = screen.columns - rhs_status_len

        for element in elements:
            _draw_element(
                element["title"],
                screen,
                tab,
                before,
                100,
                index,
                colors,
                filled=RHS_STATUS_FILLED,
                padded=False,
                accented=element["accented"],
                icon=element["icon"],
                soft_sep=PADDING if element is not elements[-1] else None,
            )

    return end
