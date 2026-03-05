<p align="center">
  <h1 align="center">my-nvim</h1>
  <p align="center">一键脚本自动配置 Neovim &mdash; 基于 Lua 的现代化开发环境</p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.9%2B-57A143?style=flat-square&logo=neovim&logoColor=white" />
  <img src="https://img.shields.io/badge/Config-Lua-2C2D72?style=flat-square&logo=lua&logoColor=white" />
  <img src="https://img.shields.io/badge/Plugin_Manager-lazy.nvim-B4A7D6?style=flat-square" />
</p>

---

## 快速开始

```bash
git clone https://github.com/leonlee2013/my-nvim.git
cd my-nvim
bash install.sh
nvim                # 首次启动自动安装所有插件
```

> 脚本会自动完成：安装 Neovim、检查依赖、安装 Nerd Font、备份旧配置、部署新配置。

---

## 依赖

| 工具 | 用途 | 安装方式 |
|:-----|:-----|:---------|
| **Neovim** >= 0.9 | 编辑器 | 脚本自动安装 |
| **git** | 插件管理 | `apt install git` |
| **gcc** + **make** | 编译 telescope-fzf | `apt install build-essential` |
| **ripgrep** | 全局搜索 | `apt install ripgrep` |
| **fd** | 文件查找 | `apt install fd-find` |
| [**Nerd Font**](https://www.nerdfonts.com/) | 图标显示 | 需在本地终端安装 (见下方说明) |

> **Nerd Font 安装说明**
>
> nvim-tree、lualine 等插件依赖 Nerd Font 显示图标。如果通过 **SSH 远程连接**，字体渲染发生在本地，需要在**本地电脑**上操作：
>
> 1. 下载 [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz) 并安装到本地系统
> 2. 在终端软件中将字体设置为 `JetBrainsMono Nerd Font`：
>    - **Windows Terminal**：设置 → 配置文件 → 外观 → 字体
>    - **iTerm2**：Preferences → Profiles → Text → Font
>    - **Alacritty**：`~/.config/alacritty/alacritty.toml` → `[font.normal] family`
>    - **Kitty**：`~/.config/kitty/kitty.conf` → `font_family`

---

## 插件一览

### 核心框架

| 插件 | 替代 | 说明 |
|:-----|:-----|:-----|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Vim 8 pack | 插件管理器，按需加载 |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | *新增* | 语法高亮 + 代码解析 |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | *新增* | LSP / Formatter 安装管理 |

### 编辑增强

| 插件 | 替代 | 说明 |
|:-----|:-----|:-----|
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | YouCompleteMe + SuperTab | 代码补全引擎 |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | UltiSnips | 代码片段 |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | vim-commentary | 快速注释 `gcc` / `gc` |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | *新增* | 自动括号配对 |

### 导航 & 搜索

| 插件 | 替代 | 说明 |
|:-----|:-----|:-----|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | ctrlp.vim | 模糊查找文件 / 内容 / 符号 |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | NERDTree | 侧边文件浏览器 |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | taglist | 代码大纲 |

### Git

| 插件 | 替代 | 说明 |
|:-----|:-----|:-----|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | vim-gitgutter + blamer.nvim | 行内 diff + blame |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | vim-fugitive | Git 命令集成 |

### 语言支持

| 插件 | 替代 | 说明 |
|:-----|:-----|:-----|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | vim-lsp + vim-lsp-settings | 语言服务协议 (LSP) |
| [go.nvim](https://github.com/ray-x/go.nvim) | vim-go | Go 开发工具 |

### 外观

| 插件 | 替代 | 说明 |
|:-----|:-----|:-----|
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 手动 statusline | 状态栏 |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | *新增* | 按键后弹出快捷键提示 |

### 高亮增强

| 插件 | 说明 |
|:-----|:-----|
| [vim-illuminate](https://github.com/RRethy/vim-illuminate) | 自动高亮光标下单词的所有出现位置 |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | 缩进参考线 + 作用域高亮 |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | 嵌套括号彩虹着色 |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO / FIXME / NOTE 关键字高亮 |
| [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) | 颜色代码内联预览 |

### 颜色主题

| 插件 | 说明 |
|:-----|:-----|
| [catppuccin](https://github.com/catppuccin/nvim) | **默认主题**，柔和暖色调，全插件适配 |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | 现代深色主题，4 种风格 |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | 日本画风灵感，沉稳古典 |
| [rose-pine](https://github.com/rose-pine/neovim) | 极简素雅，低对比度护眼 |
| [sonokai](https://github.com/sainnhe/sonokai) | Monokai 现代升级版，5 种风格 |

---

## 快捷键速查

> **Leader 键 = `,`**

### 通用编辑

| 快捷键 | 功能 | 快捷键 | 功能 |
|:-------|:-----|:-------|:-----|
| `,a` | 全选 | `,h` | 清除搜索高亮 |
| `,w` | 替换光标下单词 | `,wc` | 替换单词 (逐个确认) |
| `,"` | 给单词加引号 | `,xt` | 插入日期时间 *(插入模式)* |
| `,y` | 复制到系统剪贴板 | `,p` | 从系统剪贴板粘贴 |
| `,rl` | 重新加载文件 | `F9` | 切换代码大纲 |

### Telescope 查找

| 快捷键 | 功能 | 快捷键 | 功能 |
|:-------|:-----|:-------|:-----|
| `Ctrl+p` | 查找文件 | `,e` | 最近访问的文件 |
| `,t` | 切换 Buffer | `,r` | 文档符号 |
| `,f` | 搜索光标下单词 | `,fg` | 全局搜索 (live grep) |
| `,fG` | 搜索 Go 文件 | `,fd` | 诊断信息 |

### 文件浏览器

| 快捷键 | 功能 |
|:-------|:-----|
| `Ctrl+n` | 切换文件树 |
| `Ctrl+f` | 定位当前文件 |

### LSP (所有语言)

| 快捷键 | 功能 | 快捷键 | 功能 |
|:-------|:-----|:-------|:-----|
| `gd` | 跳转到定义 | `gD` | 跳转到声明 |
| `gi` | 跳转到实现 | `gr` | 查找引用 |
| `K` | 悬停文档 | `,rn` | 重命名 |
| `,ca` | 代码操作 | `,co` | 文档符号 |
| `,gc` | 查找调用者 | `,gd` | 查找被调用 |
| `[d` | 上一个诊断 | `]d` | 下一个诊断 |

### Go 开发 *(仅 Go 文件生效)*

| 快捷键 | 功能 | 快捷键 | 功能 |
|:-------|:-----|:-------|:-----|
| `,b` | Go Build | `,gR` | Go Run |
| `,gT` | Go Test | `,gC` | Go Coverage |
| `,ga` | Go Add Tags | | |

### Claude Code

| 快捷键 | 功能 |
|:-------|:-----|
| `,cl` | 打开 Claude 终端 (垂直分屏) |
| `,clh` | 打开 Claude 终端 (水平分屏) |

---

## 目录结构

```
nvim/
├── init.lua              入口: 引导 lazy.nvim, 加载模块
└── lua/
    ├── options.lua       编辑器基础选项
    ├── keymaps.lua       通用快捷键映射
    ├── autocmds.lua      自动命令
    └── plugins.lua       插件定义与配置
```

---

## 切换主题

默认主题为 **catppuccin** (mocha)，可用 `:colorscheme` 临时切换：

```vim
:colorscheme catppuccin       " 柔和暖色 (默认 mocha 口味)
:colorscheme tokyonight       " 现代深蓝
:colorscheme kanagawa         " 沉稳古典
:colorscheme rose-pine        " 素雅清新
:colorscheme sonokai          " Monokai 升级版
```

持久修改：编辑 `nvim/lua/plugins.lua` 底部主题配置块，将 `vim.cmd.colorscheme("catppuccin")` 改为目标主题名。
