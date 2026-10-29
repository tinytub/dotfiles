#!/bin/zsh
set -e
set -u
set -o pipefail

# === Config ===
# MODE=smart：仅删除“非 utun4”的更精细前缀，保留已走 utun4 的主机/前缀（更稳）
# MODE=force：清掉 198.18.* 下除了 /16 以外的所有前缀/主机，做到“全部靠 /16 走 utun4”
MODE="${1:-smart}" # smart 或 force
TARGET_NET="198.18.0.0/16"
TARGET_IF="utun4"

log() {
    echo "[fix19818] $*"
    if command -v logger >/dev/null 2>&1; then
        logger -t fix19818 "$*"
    fi
}

have_if() {
    ifconfig "$1" >/dev/null 2>&1
}

route_add_utun4() {
    # 只删除现有路由，避免无效操作
    if route -n get "$TARGET_NET" >/dev/null 2>&1; then
        sudo route delete -net "$TARGET_NET" >/dev/null 2>&1 || true
    fi

    sudo route -n add -net "$TARGET_NET" -interface "$TARGET_IF"
}

delete_route() {
    local dst="$1"
    if route -n get "$dst" >/dev/null 2>&1; then
        sudo route -n delete -net "$dst" 2>/dev/null || sudo route -n delete "$dst" 2>/dev/null || true
    fi
}

delete_non_utun4_routes() {
    # 收集所有198.18.*的路由
    local routes_raw
    routes_raw=$(netstat -nr | awk '$1 ~ /^198\.18\./ {print $1"\t"$NF}')

    if [[ -z "$routes_raw" ]]; then
        log "未发现 198.18.* 的其他路由，完成。"
        return
    fi

    # 使用 while 循环逐行读取路由
    while IFS=$'\t' read -r dst nif; do
        # 跳过 198.18.0/16 网络本身
        if [[ "$dst" == "$TARGET_NET" || "$dst" == "198.18/16" || "$dst" == "198.18.0/16" ]]; then
            continue
        fi

        if [[ "$nif" != "$TARGET_IF" ]]; then
            log "删除非 utun4 路由: $dst via $nif"
            delete_route "$dst"
        fi
    done <<<"$routes_raw"
}

main() {
    if ! have_if "$TARGET_IF"; then
        log "接口 $TARGET_IF 不存在，跳过。"
        exit 0
    fi

    log "确保 $TARGET_NET 走 $TARGET_IF ..."
    route_add_utun4

    # 删除所有非 utun4 的 198.18.* 路由
    delete_non_utun4_routes

    # 再保险一次，确保通过 utun4 的路由正确
    route_add_utun4
    log "完成。模式=$MODE"
}

main "$@"
