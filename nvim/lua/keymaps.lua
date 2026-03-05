local map = vim.keymap.set

-- 全选
map("n", "<leader>a", "ggVG", { desc = "全选" })

-- 行号开关
map("n", "<leader>no", "<cmd>set nonumber<CR>", { desc = "隐藏行号" })
map("n", "<leader>nu", "<cmd>set number<CR>", { desc = "显示行号" })

-- 清除搜索高亮
map("n", "<leader>h", "<cmd>nohl<CR>", { desc = "清除搜索高亮" })

-- 单词替换
map("n", "<leader>w", [[:%s/<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/g<Left><Left>]], { desc = "替换光标下单词" })
map("n", "<leader>wc", [[:%s/\<<C-r>=expand("<cword>")<CR>\>/<C-r>=expand("<cword>")<CR>/gc<Left><Left><Left>]], { desc = "替换光标下单词(确认)" })

-- 给单词加引号
map("n", '<leader>"', [[:s/<C-r><C-w>/"<C-r><C-w>"/<CR>]], { desc = "给单词加引号" })
map("v", '<leader>"', [[y:s/<C-r>0/"<C-r>0"/<CR>]], { desc = "给选中文本加引号" })

-- 搜索选中文本
map("v", "<leader>fv", [[y/<C-R>"<CR>]], { desc = "搜索选中文本" })

-- 插入日期时间
map("i", "<leader>xt", '<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>', { desc = "插入日期时间" })

-- 系统剪贴板
map("v", "<leader>y", '"+y', { desc = "复制到系统剪贴板" })
map("n", "<leader>y", '"+yy', { desc = "复制当前行到系统剪贴板" })
map("n", "<leader>p", '"+p', { desc = "从系统剪贴板粘贴" })

-- 重新加载文件
map("n", "<leader>rl", "<cmd>e!<CR>", { desc = "重新加载文件" })

-- 窗口导航
map("n", "<C-h>", "<C-w>h", { desc = "切换到左窗口" })
map("n", "<C-j>", "<C-w>j", { desc = "切换到下窗口" })
map("n", "<C-k>", "<C-w>k", { desc = "切换到上窗口" })
map("n", "<C-l>", "<C-w>l", { desc = "切换到右窗口" })

-- Terminal 模式导航
map("t", "<C-h>", "<C-\\><C-N><C-w>h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k")
map("t", "<C-l>", "<C-\\><C-N><C-w>l")
map("t", "<Esc>", "<C-\\><C-N>", { desc = "退出终端模式" })

-- Claude Code 集成
map("n", "<leader>cl", "<cmd>rightbelow vsplit | terminal claude<CR>", { desc = "Claude终端(垂直)" })
map("n", "<leader>clh", "<cmd>split | terminal claude<CR>", { desc = "Claude终端(水平)" })
