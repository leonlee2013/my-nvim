<p align="center">
  <h1 align="center">my-nvim</h1>
  <p align="center">一键脚本自动配置 Neovim &mdash; 基于 Lua 的现代化开发环境</p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.11%2B-57A143?style=flat-square&logo=neovim&logoColor=white" />
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
| **Neovim** >= 0.11 | 编辑器 | 脚本自动安装 |
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
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | vim-lsp + vim-lsp-settings | LSP 语言服务，使用 Neovim 0.11+ 原生 API |
| [go.nvim](https://github.com/ray-x/go.nvim) | vim-go | Go 开发工具 (build/test/coverage/tags) |

> **Go 高亮增强**：gopls 已启用 `semanticTokens`，可区分包名、结构体、接口、方法、参数等不同语义元素的颜色。
> 配置的 LSP 服务器：`gopls` / `lua_ls` / `clangd` / `pyright`

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

### AI 代码助手

| 插件 | 说明 |
|:-----|:-----|
| [avante.nvim](https://github.com/yetone/avante.nvim) | AI 驱动的代码助手，类似 Cursor IDE 体验 |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Avante 对话面板 Markdown 渲染 |
| [img-clip.nvim](https://github.com/HakonHarnes/img-clip.nvim) | 支持粘贴图片到 AI 对话 |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim) | 美化输入框 / 选择框 UI |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI 组件库 (Avante 面板依赖) |

### 颜色主题

| 插件 | 说明 |
|:-----|:-----|
| [onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim) | **默认主题** (onedark_vivid)，VS Code One Dark 风格，4 种变体 |
| [catppuccin](https://github.com/catppuccin/nvim) | 柔和暖色调，全插件适配 |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | 现代深色主题，4 种风格 |
| [vscode.nvim](https://github.com/Mofiqul/vscode.nvim) | VS Code Dark+ 主题移植 |
| [github-nvim-theme](https://github.com/projekt0n/github-nvim-theme) | GitHub 官方配色，多种变体 |

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
| `,no` | 隐藏行号 | `,nu` | 显示行号 |

### 窗口导航

| 快捷键 | 功能 | 快捷键 | 功能 |
|:-------|:-----|:-------|:-----|
| `Ctrl+h` | 切换到左窗口 | `Ctrl+l` | 切换到右窗口 |
| `Ctrl+j` | 切换到下窗口 | `Ctrl+k` | 切换到上窗口 |
| `Esc` *(终端模式)* | 退出终端模式 | | |

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

### Avante AI 助手

| 快捷键 | 功能 | 快捷键 | 功能 |
|:-------|:-----|:-------|:-----|
| `,aa` | 打开 AI 对话 | `,at` | 切换侧栏显示 |
| `,ae` | 编辑选中代码 | `,af` | 切换侧栏焦点 |
| `,ar` | 刷新侧栏 | `,a?` | 选择模型 |
| `,an` | 新建对话 | `,ah` | 历史对话列表 |
| `,ac` | 添加当前文件到上下文 | `,aS` | 停止当前请求 |
| `,a+` | 添加文件 *(NvimTree)* | `,a-` | 移除文件 *(NvimTree)* |

**侧栏内操作：**

| 快捷键 | 功能 | 快捷键 | 功能 |
|:-------|:-----|:-------|:-----|
| `A` | 应用所有建议 | `a` | 应用光标处建议 |
| `r` | 重试请求 | `e` | 编辑请求 |
| `@` | 添加文件 | `d` | 移除文件 |
| `Tab` | 切换窗口 | `q` | 关闭侧栏 |

**Diff 冲突处理：**

| 快捷键 | 功能 | 快捷键 | 功能 |
|:-------|:-----|:-------|:-----|
| `co` | 保留我的代码 | `ct` | 采用 AI 建议 |
| `ca` | 全部采用 AI | `cb` | 两者都保留 |
| `]x` | 下一个冲突 | `[x` | 上一个冲突 |

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

默认主题为 **onedark_vivid** (One Dark 高饱和度变体)，可用 `:colorscheme` 临时切换：

```vim
:colorscheme onedark_vivid    " VS Code One Dark 高饱和 (默认)
:colorscheme onedark          " VS Code One Dark 经典
:colorscheme onedark_dark     " VS Code One Dark 深色
:colorscheme catppuccin       " 柔和暖色 (mocha)
:colorscheme tokyonight       " 现代深蓝
:colorscheme vscode           " VS Code Dark+ 原版
:colorscheme github_dark      " GitHub 暗色
```

持久修改：编辑 `nvim/lua/plugins.lua` 底部主题配置块，将 `vim.cmd.colorscheme("onedark_vivid")` 改为目标主题名。
