return {
  -- ====================================================
  -- Telescope 模糊查找 (替代 ctrlp.vim)
  -- ====================================================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Esc>"] = actions.close,
            },
          },
          layout_config = {
            horizontal = { preview_width = 0.55 },
            width = 0.87,
            height = 0.80,
          },
        },
      })
      pcall(telescope.load_extension, "fzf")

      local builtin = require("telescope.builtin")
      local map = vim.keymap.set
      map("n", "<C-p>", builtin.find_files, { desc = "查找文件" })
      map("n", "<leader>e", builtin.oldfiles, { desc = "最近访问的文件" })
      map("n", "<leader>t", builtin.buffers, { desc = "切换Buffer" })
      map("n", "<leader>r", builtin.lsp_document_symbols, { desc = "文档符号" })
      map("n", "<leader>f", builtin.grep_string, { desc = "搜索光标下单词" })
      map("n", "<leader>fg", builtin.live_grep, { desc = "全局搜索" })
      map("n", "<leader>fd", builtin.diagnostics, { desc = "诊断信息" })
      map("v", "<leader>f", function()
        vim.cmd('normal! "zy')
        builtin.grep_string({ search = vim.fn.getreg("z") })
      end, { desc = "搜索选中文本" })
      -- 仅在 Go 文件中搜索 (替代 <leader>fg -> <leader>fG 避免与 live_grep 冲突)
      map("n", "<leader>fG", function()
        builtin.grep_string({ glob_pattern = "*.{go,mod,proto}" })
      end, { desc = "搜索Go文件" })
    end,
  },

  -- ====================================================
  -- nvim-tree 文件浏览器 (替代 NERDTree)
  -- ====================================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        view = { width = 35 },
        filters = { dotfiles = false },
        git = { enable = true },
      })
      vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "切换文件树" })
      vim.keymap.set("n", "<C-f>", "<cmd>NvimTreeFindFile<CR>", { desc = "定位当前文件" })
    end,
  },

  -- ====================================================
  -- Comment.nvim 注释 (替代 vim-commentary)
  -- ====================================================
  { "numToStr/Comment.nvim", config = true },

  -- ====================================================
  -- Git 集成 (替代 vim-gitgutter + blamer.nvim + vim-fugitive)
  -- ====================================================
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 500,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      })
    end,
  },
  { "tpope/vim-fugitive" },

  -- ====================================================
  -- Treesitter 语法高亮 + 代码解析
  -- ====================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "go", "gomod", "gosum", "gowork",
          "lua", "vim", "vimdoc",
          "c", "cpp",
          "python",
          "bash", "json", "yaml", "toml",
          "markdown", "markdown_inline",
          "proto",
        },
      })
    end,
  },

  -- ====================================================
  -- 高亮增强
  -- ====================================================
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
        filetypes_denylist = { "NvimTree", "aerial", "TelescopePrompt" },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = true, show_start = true },
      })
    end,
  },
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          css = true,
          names = false,
        },
      })
    end,
  },

  -- ====================================================
  -- LSP 语言服务 (替代 vim-lsp + vim-lsp-settings + YCM)
  -- 使用 Neovim 0.11+ 原生 vim.lsp.config API
  -- ====================================================
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "lua_ls", "clangd", "pyright" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason.nvim", "mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local m = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          m("n", "gd", vim.lsp.buf.definition, "跳转到定义")
          m("n", "gD", vim.lsp.buf.declaration, "跳转到声明")
          m("n", "gi", vim.lsp.buf.implementation, "跳转到实现")
          m("n", "gr", vim.lsp.buf.references, "查找引用")
          m("n", "K", vim.lsp.buf.hover, "悬停信息")
          m("n", "<leader>rn", vim.lsp.buf.rename, "重命名")
          m("n", "<leader>ca", vim.lsp.buf.code_action, "代码操作")
          m("n", "<leader>gf", vim.lsp.buf.definition, "跳转到定义")
          m("n", "<leader>gl", vim.lsp.buf.declaration, "跳转到声明")
          m("n", "<leader>gc", vim.lsp.buf.incoming_calls, "查找调用者")
          m("n", "<leader>gd", vim.lsp.buf.outgoing_calls, "查找被调用")
          m("n", "<leader>co", function()
            require("telescope.builtin").lsp_document_symbols()
          end, "文档符号")
          m("n", "<leader>ch", vim.lsp.buf.hover, "悬停信息")
          m("n", "<leader>cp", vim.lsp.buf.definition, "预览定义")
          m("n", "[d", vim.diagnostic.goto_prev, "上一个诊断")
          m("n", "]d", vim.diagnostic.goto_next, "下一个诊断")
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            semanticTokens = true,
            analyses = {
              unusedparams = true,
              unusedwrite = true,
              useany = true,
              nilness = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.enable({ "gopls", "lua_ls", "clangd", "pyright" })
    end,
  },

  -- ====================================================
  -- 代码补全 (替代 YouCompleteMe + UltiSnips + SuperTab)
  -- ====================================================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  -- ====================================================
  -- Go 开发 (替代 vim-go)
  -- ====================================================
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        lsp_gofumpt = true,
        lsp_on_attach = false,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "go", "gomod" },
        callback = function()
          local opts = function(desc)
            return { buffer = true, desc = desc }
          end
          vim.keymap.set("n", "<leader>b", "<cmd>GoBuild<CR>", opts("Go Build"))
          vim.keymap.set("n", "<leader>gR", "<cmd>GoRun<CR>", opts("Go Run"))
          vim.keymap.set("n", "<leader>gT", "<cmd>GoTest<CR>", opts("Go Test"))
          vim.keymap.set("n", "<leader>gC", "<cmd>GoCoverage<CR>", opts("Go Coverage"))
          vim.keymap.set("n", "<leader>gi", "<cmd>GoImplements<CR>", opts("Go Implements"))
          vim.keymap.set("n", "<leader>ga", "<cmd>GoAddTag<CR>", opts("Go Add Tags"))
        end,
      })
    end,
    lazy = false,
    build = ':lua require("go.install").update_all_sync()',
  },

  -- ====================================================
  -- Aerial 代码大纲 (替代 taglist)
  -- ====================================================
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        layout = { default_direction = "right", min_width = 30 },
      })
      vim.keymap.set("n", "<F9>", "<cmd>AerialToggle!<CR>", { desc = "切换代码大纲" })
    end,
  },

  -- ====================================================
  -- Lualine 状态栏 (替代手动 statusline)
  -- ====================================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- ====================================================
  -- Which-key 快捷键提示
  -- ====================================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- ====================================================
  -- 自动括号配对
  -- ====================================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- ====================================================
  -- 颜色主题
  -- 切换: :colorscheme <name>
  -- 可选: onedark_vivid (默认) / onedark / onedark_dark
  --        catppuccin / tokyonight / vscode / github_dark
  -- ====================================================
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        colors = {
          onedark_vivid = {
            bg = "#171a24",
          },
        },
        highlights = {
          ["@lsp.type.namespace.go"] = { fg = "${yellow}" },
          ["@lsp.type.interface.go"] = { fg = "${yellow}", italic = true },
          ["@lsp.type.typeParameter.go"] = { fg = "${cyan}" },
          ["@lsp.type.parameter.go"] = { fg = "${orange}" },
          ["@lsp.mod.readonly.go"] = { bold = true },
        },
      })
      vim.cmd.colorscheme("onedark_vivid")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        custom_highlights = function(colors)
          return {
            ["@lsp.type.namespace.go"] = { fg = colors.yellow },
            ["@lsp.type.interface.go"] = { fg = colors.yellow, style = { "italic" } },
            ["@lsp.type.typeParameter.go"] = { fg = colors.teal },
            ["@lsp.type.parameter.go"] = { fg = colors.maroon },
            ["@lsp.mod.readonly.go"] = { style = { "bold" } },
          }
        end,
        integrations = {
          aerial = true,
          avante = true,
          cmp = true,
          gitsigns = true,
          illuminate = { enabled = true },
          indent_blankline = { enabled = true },
          mason = true,
          nvimtree = true,
          rainbow_delimiters = true,
          render_markdown = true,
          telescope = { enabled = true },
          treesitter = true,
          which_key = true,
        },
      })
    end,
  },
  { "folke/tokyonight.nvim", lazy = true },
  { "Mofiqul/vscode.nvim", lazy = true },
  { "projekt0n/github-nvim-theme", lazy = true },

  -- ====================================================
  -- Avante AI 代码助手
  -- <leader>aa 打开对话 / <leader>ae 编辑选中代码
  -- <leader>at 切换侧栏 / <leader>af 切换焦点
  -- ====================================================
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    keys = {
      {
        "<leader>a+",
        function()
          require("avante.extensions.nvim_tree").add_file()
        end,
        desc = "Avante: 添加文件",
        ft = "NvimTree",
      },
      {
        "<leader>a-",
        function()
          require("avante.extensions.nvim_tree").remove_file()
        end,
        desc = "Avante: 移除文件",
        ft = "NvimTree",
      },
    },
    opts = {
      provider = "claude",
      mode = "agentic",
      instructions_file = "avante.md",
      providers = {
        claude = {
          endpoint = os.getenv("ANTHROPIC_BASE_URL") or "https://api.anthropic.com",
          model = os.getenv("ANTHROPIC_DEFAULT_OPUS_MODEL") or "claude-opus-4-6",
          api_key_name = "ANTHROPIC_AUTH_TOKEN",
          timeout = 30000,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        minimize_diff = true,
        enable_token_counting = true,
      },
      input = {
        provider = "dressing",
      },
      selector = {
        provider = "telescope",
        exclude_auto_select = { "NvimTree" },
      },
      windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = { enabled = true, align = "center", rounded = true },
        input = { prefix = "> ", height = 8 },
        edit = { border = "rounded", start_insert = true },
        ask = {
          floating = false,
          start_insert = true,
          border = "rounded",
          focus_on_apply = "ours",
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "stevearc/dressing.nvim",
        opts = {
          select = { backend = { "telescope", "builtin" } },
        },
      },
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
