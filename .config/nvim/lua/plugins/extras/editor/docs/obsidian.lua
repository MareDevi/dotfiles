return {
  { import = "plugins.extras.lang.markdown-extended" },
  {
    "obsidian-nvim/obsidian.nvim",
    event = "BufReadPre ".. vim.fn.expand("~").. "/documents/obsidian/Mavi/**.md", -- 请确保这里的路径与你的 Vault 路径一致

    -- 按键绑定保持不变，它们是相当高效的默认设置
    keys = {
      { "<leader>oo", "<cmd>Obsidian open<CR>", desc = "在 Obsidian 应用中打开" },
      { "<leader>og", "<cmd>Obsidian search<CR>", desc = "全局搜索 (Grep)" },
      { "<leader>on", "<cmd>Obsidian new<CR>", desc = "新建笔记 (至收件箱)" },
      { "<leader>oN", "<cmd>Obsidian new_from_template<CR>", desc = "从模板新建笔记" },
      { "<leader>o<space>", "<cmd>Obsidian quick_switch<CR>", desc = "快速切换" },
      { "<leader>ob", "<cmd>Obsidian backlinks<CR>", desc = "反向链接" },
      { "<leader>ot", "<cmd>Obsidian tags<CR>", desc = "标签" },
      { "<leader>oT", "<cmd>Obsidian template<CR>", desc = "插入模板" },
      { "<leader>oL", "<cmd>Obsidian link<CR>", mode = "v", desc = "创建链接 (可视化模式)" },
      { "<leader>ol", "<cmd>Obsidian links<CR>", desc = "笔记中的链接" },
      { "<leader>ol", "<cmd>Obsidian link_new<CR>", mode = "v", desc = "创建新链接 (可视化模式)" },
      { "<leader>oe", "<cmd>Obsidian extract_note<CR>", mode = "v", desc = "提取笔记 (可视化模式)" },
      { "<leader>ow", "<cmd>Obsidian workspace<CR>", desc = "工作区" },
      { "<leader>or", "<cmd>Obsidian rename<CR>", desc = "重命名" },
      { "<leader>oi", "<cmd>Obsidian paste_img<CR>", desc = "粘贴图片" },
      { "<leader>od", "<cmd>Obsidian dailies<CR>", desc = "每日笔记" },
    },

    opts = {
      -- 工作区配置
      workspaces = {
        {
          name = "Mavi", -- 你可以改成自己喜欢的名字
          path = "~/documents/obsidian/Mavi", -- ❗️重要：请务必修改为你的 Obsidian Vault 的实际路径
        },
      },

      -- 默认新笔记存放位置，指向我们的收件箱
      notes_subdir = "00_Inbox", -- 原配置为 "01 - Bandeja Entrada"

      -- 每日笔记配置
      daily_notes = {
        folder = "01_Daily", -- 建议为每日笔记创建一个专门的顶级文件夹
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        template = "90_Meta/Templates/Daily Note Template.md", -- 指向我们结构中的模板
      },

      completion = {
        nvim_cmp = false,
        blink = true,
      },

      -- 对于 :ObsidianNew 命令，新笔记默认进入 'notes_subdir' (即收件箱)
      new_notes_location = "notes_subdir",

      -- 模板文件夹路径
      templates = {
        subdir = "90_Meta/Templates", -- 原配置为 "00 - Data/Plantillas"
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },

      -- 附件 (图片等) 文件夹路径
      attachments = {
        img_folder = "90_Meta/Attachments", -- 原配置为 "00 - Data/Documentos"
      },

      -- 自动为新笔记生成符合我们系统规范的元数据 (Properties)
      note_frontmatter_func = function(note)
        -- 将标题自动添加为别名，便于链接
        if note.title then
          note:add_alias(note.title)
        end

        -- 构建符合我们第二大脑架构的元数据
        local out = {
          aliases = note.aliases,
          created = os.date("%Y-%m-%dT%H:%M:%S"), -- 自动添加创建时间戳
          status = "incubating", -- 默认状态为“孵化中”，等待后续处理
          context = "resource/uncategorized", -- 默认上下文，提醒你进行归类
          tags = {}, -- 初始化一个空的标签列表
        }

        -- 合并任何在创建时可能传入的额外元数据
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      -- 以下为原配置中优秀的部分，予以保留
      picker = {
        name = "snacks.pick",
        note_mappings = {
          new = "<C-x>",
          insert_link = "<C-l>",
        },
        tag_mappings = {
          tag_note = "<C-x>",
          insert_tag = "<C-l>",
        },
      },
      callbacks = {
        enter_note = function(_, note)
          vim.keymap.set("n", "gf", "<cmd>ObsidianFollowLink<cr>", {
            buffer = note.bufnr,
            expr = note.expr,
            noremap = note.noremap,
            desc = "File Passthrough",
          })
        end,
      },
      follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url }) -- 在 Linux 系统上工作的很好
      end,
    },
  },
  -- 确保 snacks.nvim 插件已安装，因为 picker 和自定义任务搜索依赖它
  {
    "folke/snacks.nvim",
    -- 这里的按键绑定是查找 Markdown 任务列表项，非常实用
    keys = {
      {
        "<leader>ok",
        function()
          require("snacks").picker.grep({
            search = "^%s*- %[%s%]", -- 正则表达式查找未完成的任务
            regex = true,
            dirs = { vim.fn.getcwd() },
          })
        end,
        desc = "查找未完成的任务",
      },
      {
        "<leader>oK",
        function()
          require("snacks").picker.grep({
            search = "^%s*- %s*%[x%]:", -- 正则表达式查找已完成的任务
            regex = true,
            dirs = { vim.fn.getcwd() },
          })
        end,
        desc = "查找已完成的任务",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>o", group = "obsidian", icon = "obsidian", mode = { "n", "v" } },
      },
    },
  },
}