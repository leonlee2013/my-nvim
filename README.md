# my-nvim

通过脚本一键自动配置 Neovim，基于 Lua 的现代化配置。

## 快速安装

```bash
git clone https://github.com/leonlee2013/my-nvim.git
cd my-nvim
bash install.sh
```

首次启动 `nvim` 时会自动安装所有插件。

## 依赖

| 工具 | 用途 | 安装 |
|------|------|------|
| Neovim >= 0.9 | 编辑器 | 脚本自动安装 |
| git | 插件管理 | `apt install git` |
| gcc + make | 编译 telescope-fzf | `apt install build-essential` |
| ripgrep | 全局搜索 | `apt install ripgrep` |
| fd | 文件查找 | `apt install fd-find` |
| [Nerd Font](https://www.nerdfonts.com/) | 图标显示 | 脚本自动安装 JetBrainsMono |

## 插件列表

| Neovim 插件 | 替代的 Vim 插件 | 功能 |
|-------------|----------------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Vim 8 pack | 插件管理器 |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | ctrlp.vim | 模糊查找 |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | NERDTree | 文件浏览器 |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | vim-commentary | 快速注释 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | vim-gitgutter + blamer.nvim | Git 差异 + 行内 blame |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | vim-fugitive | Git 命令集成 |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | - | 语法高亮 + 代码解析 |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | vim-lsp + vim-lsp-settings | 语言服务协议 |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | - | LSP 服务器安装管理 |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | YouCompleteMe + SuperTab | 代码补全 |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | UltiSnips | 代码片段 |
| [go.nvim](https://github.com/ray-x/go.nvim) | vim-go | Go 开发工具 |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | taglist | 代码大纲 |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 手动 statusline | 状态栏 |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | - | 快捷键提示 |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | - | 自动括号配对 |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | molokai / jellybeans | 颜色主题 |
| [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) | gruvbox | 颜色主题(备选) |

## 快捷键

Leader 键: `,`

### 通用

| 快捷键 | 功能 |
|--------|------|
| `<leader>a` | 全选 |
| `<leader>h` | 清除搜索高亮 |
| `<leader>w` | 替换光标下单词 |
| `<leader>wc` | 替换光标下单词(需确认) |
| `<leader>"` | 给单词加引号 |
| `<leader>xt` | 插入日期时间 (插入模式) |
| `<leader>y` | 复制到系统剪贴板 |
| `<leader>p` | 从系统剪贴板粘贴 |
| `<leader>rl` | 重新加载文件 |
| `<F9>` | 切换代码大纲 |

### Telescope 查找

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+p` | 查找文件 |
| `<leader>e` | 最近访问的文件 |
| `<leader>t` | 切换 Buffer |
| `<leader>r` | 文档符号 |
| `<leader>f` | 搜索光标下单词 |
| `<leader>fg` | 全局搜索 (live grep) |
| `<leader>fG` | 搜索 Go 文件 |
| `<leader>fd` | 诊断信息 |

### 文件浏览器

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+n` | 切换文件树 |
| `Ctrl+f` | 定位当前文件 |

### LSP (所有语言)

| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gi` | 跳转到实现 |
| `gr` | 查找引用 |
| `K` | 悬停信息 |
| `<leader>rn` | 重命名 |
| `<leader>ca` | 代码操作 |
| `<leader>gc` | 查找调用者 |
| `<leader>gd` | 查找被调用 |
| `<leader>co` | 文档符号 |
| `[d` / `]d` | 上/下一个诊断 |

### Go 开发 (仅 Go 文件)

| 快捷键 | 功能 |
|--------|------|
| `<leader>b` | Go Build |
| `<leader>gR` | Go Run |
| `<leader>gT` | Go Test |
| `<leader>gC` | Go Coverage |
| `<leader>ga` | Go Add Tags |

### Claude Code

| 快捷键 | 功能 |
|--------|------|
| `<leader>cl` | 打开 Claude 终端 (垂直) |
| `<leader>clh` | 打开 Claude 终端 (水平) |

## 目录结构

```
nvim/
├── init.lua            # 入口: 引导 lazy.nvim, 加载模块
└── lua/
    ├── options.lua     # 编辑器基础选项
    ├── keymaps.lua     # 通用快捷键映射
    ├── autocmds.lua    # 自动命令
    └── plugins.lua     # 插件定义与配置
```

## 切换主题

默认使用 `tokyonight`，如需切换为 `gruvbox`，在 nvim 中执行:

```vim
:colorscheme gruvbox
```

或修改 `nvim/lua/plugins.lua` 中 tokyonight 的 config 部分。