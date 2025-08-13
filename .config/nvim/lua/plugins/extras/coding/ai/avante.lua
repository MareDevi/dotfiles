return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
      provider = "siliconcloud",
      providers = {
        siliconcloud = {
          __inherited_from = 'openai',
          endpoint = 'https://api.siliconflow.cn/v1',
          api_key_name = 'SILICONCLOUD_API_KEY',
          model = 'zai-org/GLM-4.5'
        }
      }
    },
    dependencies = {
      "MeanderingProgrammer/render-markdown.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua",
      {
        -- 支持图像粘贴
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- 推荐设置
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- Windows 用户必需
            use_absolute_path = true,
          },
        },
      },
      ft = { "markdown", "norg", "rmd", "org", "Avante" },
    },
  },
}
