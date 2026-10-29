#!/bin/bash

# --- 颜色定义 ---
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}--- SSH 主机添加助手 ---${NC}"

# --- 1. 获取用户输入 ---
read -p "请输入服务器 IP 地址或域名: " HOST_IP
if [ -z "$HOST_IP" ]; then
    echo -e "${RED}错误: IP 地址或域名不能为空。${NC}"
    exit 1
fi

read -p "请输入连接服务器的用户名 (例如: root, ubuntu, ec2-user): " HOST_USER
if [ -z "$HOST_USER" ]; then
    echo -e "${RED}错误: 用户名不能为空。${NC}"
    exit 1
fi

read -p "请输入此连接的 SSH 别名 (例如: my_server, dev_box): " HOST_ALIAS
if [ -z "$HOST_ALIAS" ]; then
    echo -e "${RED}错误: SSH 别名不能为空。${NC}"
    exit 1
fi

# --- 2. 检查并生成 SSH 密钥对 ---
SSH_KEY_PATH="$HOME/.ssh/id_rsa"
SSH_PUB_KEY_PATH="$HOME/.ssh/id_rsa.pub"

if [ ! -f "$SSH_KEY_PATH" ]; then
    echo -e "${YELLOW}检测到您没有默认的 SSH 私钥 (${SSH_KEY_PATH})。${NC}"
    read -p "是否现在生成一个新的 SSH 密钥对？(y/n): " GENERATE_KEY
    if [[ "$GENERATE_KEY" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}正在生成 SSH 密钥对...${NC}"
        ssh-keygen -t rsa -b 4096 -C "$USER@$(hostname)-$(date +%F)" -f "$SSH_KEY_PATH"
        if [ $? -ne 0 ]; then
            echo -e "${RED}错误: SSH 密钥生成失败。${NC}"
            exit 1
        fi
        echo -e "${GREEN}SSH 密钥对已生成。${NC}"
    else
        echo -e "${RED}错误: 没有可用的 SSH 私钥，无法继续。请手动生成或选择生成。${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}已检测到 SSH 私钥 (${SSH_KEY_PATH})。${NC}"
fi

# 确保公钥文件存在
if [ ! -f "$SSH_PUB_KEY_PATH" ]; then
    echo -e "${RED}错误: SSH 公钥文件 (${SSH_PUB_KEY_PATH}) 不存在。请检查您的密钥对。${NC}"
    exit 1
fi

# --- 3. 复制公钥到服务器 ---
echo -e "${YELLOW}正在尝试将公钥复制到 ${HOST_USER}@${HOST_IP}...${NC}"
echo -e "${YELLOW}您可能需要输入 ${HOST_USER}@${HOST_IP} 的密码。${NC}"

ssh-copy-id -i "$SSH_PUB_KEY_PATH" "${HOST_USER}@${HOST_IP}"
if [ $? -ne 0 ]; then
    echo -e "${RED}错误: 公钥复制失败。请检查 IP、用户名、网络连接或服务器 SSH 配置。${NC}"
    echo -e "${RED}您可能需要手动将 ${SSH_PUB_KEY_PATH} 的内容添加到服务器的 ~/.ssh/authorized_keys 文件中。${NC}"
    exit 1
fi
echo -e "${GREEN}公钥已成功复制到 ${HOST_IP}。${NC}"

# --- 4. 添加配置到 ~/.ssh/config ---
SSH_CONFIG_FILE="$HOME/.ssh/config"

# 确保 ~/.ssh 目录存在且权限正确
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# 确保 ~/.ssh/config 文件存在且权限正确
if [ ! -f "$SSH_CONFIG_FILE" ]; then
    touch "$SSH_CONFIG_FILE"
    chmod 600 "$SSH_CONFIG_FILE"
fi

# 检查别名是否已存在
if grep -q "Host $HOST_ALIAS" "$SSH_CONFIG_FILE"; then
    echo -e "${YELLOW}警告: SSH 别名 '${HOST_ALIAS}' 已存在于 ${SSH_CONFIG_FILE} 中。${NC}"
    read -p "是否覆盖现有配置？(y/n): " OVERWRITE_CONFIG
    if [[ ! "$OVERWRITE_CONFIG" =~ ^[Yy]$ ]]; then
        echo -e "${RED}操作取消。${NC}"
        exit 0
    fi
    # 如果选择覆盖，则先删除旧的配置
    sed -i '' "/Host $HOST_ALIAS/,/^$/d" "$SSH_CONFIG_FILE" # macOS sed 需要 -i ''
    echo -e "${YELLOW}旧的配置已删除。${NC}"
fi

echo -e "${YELLOW}正在将配置添加到 ${SSH_CONFIG_FILE}...${NC}"

cat <<EOF >>"$SSH_CONFIG_FILE"

Host $HOST_ALIAS
    HostName $HOST_IP
    User $HOST_USER
    IdentityFile $SSH_KEY_PATH
    # Port 22 # 如果端口不是默认的22，请取消注释并修改
    # ServerAliveInterval 60 # 保持连接活跃，防止断开
    # ServerAliveCountMax 3
EOF

echo -e "${GREEN}配置已成功添加到 ${SSH_CONFIG_FILE}。${NC}"

echo -e "${GREEN}--- 完成 ---${NC}"
echo -e "${GREEN}您现在可以使用以下命令连接到服务器：${NC}"
echo -e "  ${YELLOW}ssh ${HOST_ALIAS}${NC}" # 这一行是报错的行，确保双引号
echo -e "${GREEN}如果您的私钥有密码，您可能需要使用 'ssh-add' 将其添加到 ssh-agent。${NC}"
echo -e "  ${YELLOW}ssh-add ${SSH_KEY_PATH}${NC}" # 这一行也最好加上双引号
