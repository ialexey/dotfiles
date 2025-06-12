require("lazy").setup({
  checker = { enabled = true },
  -- LSP and completion
  {
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim", config = true, },
    { 
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")

        lspconfig.solargraph.setup({
          cmd = { "solargraph", "stdio" },
          root_dir = util.root_pattern("Gemfile", ".git", ".ruby-version"),
          settings = {
            solargraph = {
              diagnostics = true,
              completion = true,
              formatting = true,
            },
          },
        })

        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }
        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
      end
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
          defaults = {
            mappings = {
              i = { ["<Esc>"] = actions.close, ["<C-c>"] = actions.close, },
              n = { ["<Esc>"] = actions.close, ["<C-c>"] = actions.close, },
            },
          },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>rg", builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>rw", function() require("telescope.builtin").grep_string() end, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })
        vim.keymap.set("n", "<space>p", builtin.lsp_document_symbols, { desc = "Document Symbols" })
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      opts = {
        bind = true,  -- This is mandatory, otherwise the plugin won't do anything
        floating_window = true,
        hint_enable = true,
        hint_prefix = {
          above = "↙ ",  -- when the hint is on the line above the current line
          current = "← ",  -- when the hint is on the same line
          below = "↖ "  -- when the hint is on the line below the current line
        },
        hi_parameter = "LspSignatureActiveParameter",
        handler_opts = {
          border = "rounded"
        }
      }
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
      },
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          }),
        })
      end,
    },
  },
  -- Git integration
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<C-b>", ":Git blame<CR>", { silent = true })
    end
  },
  { "tpope/vim-rhubarb" }, -- GBrowse

  -- Text editing
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { silent = true })
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { silent = true })
    end
  },
  { "terryma/vim-multiple-cursors" },
  { "AndrewRadev/splitjoin.vim" },
  { "kana/vim-textobj-user" },

  { 'christoomey/vim-tmux-navigator' },

  -- Language support
  { "kchmck/vim-coffee-script", ft = "coffee" },
  { "andrewradev/vim-eco" },
  { "rust-lang/rust.vim" },
  { "elixir-editors/vim-elixir" },
  { "leafgarland/typescript-vim" },
  {
    "MaxMEllon/vim-jsx-pretty",
    ft = { "javascriptreact", "typescriptreact" },
    config = function()
      vim.api.nvim_set_hl(0, "jsxTag",              { link = "xmlTag" })
      vim.api.nvim_set_hl(0, "jsxTagName",          { link = "xmlTagName" })
      vim.api.nvim_set_hl(0, "jsxComponentName",    { link = "xmlTagName" })
      vim.api.nvim_set_hl(0, "jsxAttrib",           { link = "htmlArg" })
      vim.api.nvim_set_hl(0, "jsxOpenPunct",        { link = "xmlTag" })
      vim.api.nvim_set_hl(0, "jsxCloseString",      { link = "jsxOpenPunct" })
    end
  },

  -- Search and navigation
  { "jremmen/vim-ripgrep" },
  { "easymotion/vim-easymotion" },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<D-]>", "<Plug>(copilot-next)", { silent = true })
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      contrast = "hard",
      bold = false
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'diff', 'diagnostics'},
        lualine_c = {
          {
            'filename',
            path = 1
          }
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1
          }
        },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  },
  {
    "nvimdev/indentmini.nvim",
    config = function()
      require("indentmini").setup({
        only_current = true,
        minlevel = 2,
      })
      vim.cmd.highlight('IndentLineCurrent guifg=#928374')
      vim.cmd.highlight('IndentLine guifg=##1d2021')
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    opts = {
      open_for_directories = true,
    },
    keys = {
      {
        "-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        "g/",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
    },
  },
  {
    "yetone/avante.nvim",
    branch = "main",
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      }
    },
  },
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = {"http", "rest"},
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 100
      }
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      vim.keymap.set("n", "]n", ":Gitsigns next_hunk<CR>")
      vim.keymap.set("n", "[n", ":Gitsigns prev_hunk<CR>")
    end
  }
})
