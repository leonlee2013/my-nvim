#!/bin/bash

set -e
ABSFile=$(realpath "$0")
ExecPath=$(realpath "$(dirname "$ABSFile")")

echo "=========================================="
echo "  Neovim 自动配置安装脚本"
echo "=========================================="

# 检测并安装 Neovim
if ! command -v nvim &> /dev/null; then
  echo "[1/5] 未检测到 Neovim，正在安装..."
  if command -v apt-get &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y neovim
  elif command -v brew &> /dev/null; then
    brew install neovim
  elif command -v pacman &> /dev/null; then
    sudo pacman -S --noconfirm neovim
  elif command -v dnf &> /dev/null; then
    sudo dnf install -y neovim
  else
    echo "错误: 无法自动安装 Neovim，请手动安装"
    echo "  https://github.com/neovim/neovim/releases"
    exit 1
  fi
else
  echo "[1/5] Neovim 已安装: $(nvim --version | head -1)"
fi

# 检查依赖
echo "[2/5] 检查依赖..."
MISSING=""
for dep in git gcc make; do
  if ! command -v "$dep" &> /dev/null; then
    MISSING="$MISSING $dep"
  fi
done

if command -v rg &> /dev/null; then
  echo "  ripgrep: 已安装"
else
  echo "  ripgrep: 未安装 (建议安装，Telescope live_grep 需要)"
  echo "    apt: sudo apt install ripgrep"
  echo "    brew: brew install ripgrep"
fi

if command -v fd &> /dev/null || command -v fdfind &> /dev/null; then
  echo "  fd: 已安装"
else
  echo "  fd: 未安装 (建议安装，加速文件查找)"
  echo "    apt: sudo apt install fd-find"
  echo "    brew: brew install fd"
fi

if [ -n "$MISSING" ]; then
  echo "  警告: 缺少以下工具:$MISSING"
  echo "  部分插件 (telescope-fzf-native) 需要 gcc 和 make 来编译"
fi

# 安装 Nerd Font
echo "[3/5] 检查 Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="JetBrainsMono"
if fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd Font"; then
  echo "  JetBrainsMono Nerd Font: 已安装"
else
  echo "  正在下载 JetBrainsMono Nerd Font..."
  mkdir -p "$FONT_DIR"
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.tar.xz"
  if curl -fsSL "$FONT_URL" -o "/tmp/${FONT_NAME}.tar.xz"; then
    tar -xf "/tmp/${FONT_NAME}.tar.xz" -C "$FONT_DIR"
    rm -f "/tmp/${FONT_NAME}.tar.xz"
    if command -v fc-cache &> /dev/null; then
      fc-cache -f "$FONT_DIR"
    fi
    echo "  已安装到: $FONT_DIR"
    echo "  注意: 请在终端设置中将字体改为 \"JetBrainsMono Nerd Font\""
  else
    echo "  下载失败，跳过 (可稍后手动安装: https://www.nerdfonts.com/)"
  fi
fi

# 备份现有配置
echo "[4/5] 处理现有配置..."
CurrentDate=$(date +"%Y-%m-%d_%H-%M-%S")
NvimConfigPath="$HOME/.config/nvim"

if [ -d "$NvimConfigPath" ]; then
  echo "  备份现有配置到: ${NvimConfigPath}_${CurrentDate}"
  mv "$NvimConfigPath" "${NvimConfigPath}_${CurrentDate}"
else
  echo "  无现有 nvim 配置，跳过备份"
fi

# 复制新配置
echo "[5/5] 安装新配置..."
mkdir -p "$HOME/.config"
cp -rf "$ExecPath/nvim" "$NvimConfigPath"
echo "  配置文件已复制到: $NvimConfigPath"

echo ""
echo "=========================================="
echo "  安装完成！"
echo "=========================================="
echo ""
echo "首次启动 nvim 时将自动安装:"
echo "  - lazy.nvim 插件管理器"
echo "  - 所有配置的插件"
echo "  - Treesitter 语法解析器"
echo "  - LSP 服务器 (gopls, lua_ls, clangd, pyright)"
echo ""
echo "如果图标显示异常，请在终端设置中将字体改为 \"JetBrainsMono Nerd Font\""
echo ""
echo "运行 nvim 开始使用！"
