local present, icons = pcall(require, "nvim-web-devicons")
if not present then
    return
end

--local colors = require("base46").get_colors("base_30")
--require("base46").load_highlight "devicons"
icons.setup({
    override = {
        default_icon = {
            icon = "",
            name = "Default",
        },
        c = {
            icon = "",
            name = "c",
        },
        css = {
            icon = "",
            name = "css",
        },
        deb = {
            icon = "",
            name = "deb",
        },
        Dockerfile = {
            icon = "",
            name = "Dockerfile",
        },
        html = {
            icon = "",
            name = "html",
        },
        jpeg = {
            icon = "",
            name = "jpeg",
        },
        jpg = {
            icon = "",
            name = "jpg",
        },
        js = {
            icon = "",
            name = "js",
        },
        kt = {
            icon = "󱈙",
            name = "kt",
        },
        lock = {
            icon = "",
            name = "lock",
        },
        lua = {
            icon = "",
            name = "lua",
        },
        mp3 = {
            icon = "",
            name = "mp3",
        },
        mp4 = {
            icon = "",
            name = "mp4",
        },
        out = {
            icon = "",
            name = "out",
        },
        png = {
            icon = "",
            name = "png",
        },
        py = {
            icon = "",
            name = "py",
        },
        toml = {
            icon = "",
            name = "toml",
        },
        ts = {
            icon = "ﯤ",
            name = "ts",
        },
        rb = {
            icon = "",
            name = "rb",
        },
        rpm = {
            icon = "",
            name = "rpm",
        },
        vue = {
            icon = "﵂",
            name = "vue",
        },
        xz = {
            icon = "",
            name = "xz",
        },
        zip = {
            icon = "",
            name = "zip",
        },
    },
})
