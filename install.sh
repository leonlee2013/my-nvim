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

# Nerd Font 提示
echo "[3/5] Nerd Font 提示"
echo "  nvim-tree、lualine 等插件需要 Nerd Font 才能正确显示图标。"
echo "  如果通过 SSH 连接，字体需要安装在本地电脑上，而非服务器。"
echo ""
echo "  请在本地电脑完成以下两步:"
echo "    1. 下载安装字体: https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
echo "    2. 在终端软件中设置字体为 \"JetBrainsMono Nerd Font\":"
echo "       - Windows Terminal: 设置 → 配置文件 → 外观 → 字体"
echo "       - iTerm2: Preferences → Profiles → Text → Font"
echo "       - Alacritty: ~/.config/alacritty/alacritty.toml → [font.normal] family"
echo "       - Kitty: ~/.config/kitty/kitty.conf → font_family"
echo ""

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
echo "如果图标显示为乱码，请参考上方 [3/5] 的提示在本地安装 Nerd Font"
echo ""
echo "运行 nvim 开始使用！"
