require("lazy").setup({
  checker = { enabled = true },
  -- LSP and completion
  {
    { 
      "neovim/nvim-lspconfig",
      dependencies = {
        { "williamboman/mason.nvim", config = true },
        -- { "williamboman/mason-lspconfig.nvim", config = true, },
      },
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

        lspconfig.ts_ls.setup({
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = false,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = false,
              },
            },
          }
        })

        lspconfig.gopls.setup({
          settings = {
            gopls = {
              hints = {
                rangeVariableTypes = true,
                parameterNames = true,
                constantValues = true,
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
              },
            }
          }
        })

        vim.lsp.inlay_hint.enable(true)

        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }
        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
      end
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
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          }),
        })
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
      "zbirenbaum/copilot.lua",
      config = function()
        require("copilot").setup({
          filetypes = {
            ["*"] = true
          },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = {
              accept = "<Tab>",
              accept_word = false,
              accept_line = false,
              next = "<D-]>",
              prev = "<D-[>",
            }
          }
        })
      end
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-live-grep-args.nvim" },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local extensions = require("telescope").extensions

      telescope.setup({
        defaults = {
          mappings = {
            i = { ["<Esc>"] = actions.close, ["<C-c>"] = actions.close, },
            n = { ["<Esc>"] = actions.close, ["<C-c>"] = actions.close, },
          },
        },
      })

      telescope.load_extension("live_grep_args")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>rg", extensions.live_grep_args.live_grep_args, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>rw", builtin.grep_string, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<space>p", builtin.lsp_document_symbols, { desc = "Document Symbols" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master', 
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- optional, jump forward to nearest textobj
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["am"] = "@function.outer",
              ["im"] = "@function.inner",
              ["ib"] = "@block.inner",
              ["ab"] = "@block.outer",
              ["ir"] = "@block.inner",
              ["ar"] = "@block.outer",
            },
            include_surrounding_whitespace = true,
          },
        },
      })

      vim.api.nvim_set_hl(0, "@field", { link = "Identifier" })
    end
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  { "tpope/vim-unimpaired", lazy = false, },

  -- Git integration
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<C-b>", ":Git blame<CR>", { silent = true })
    end
  },
  { "tpope/vim-rhubarb" }, -- GBrowse
  -- lazy.nvim

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
  { 
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_maps = {
        ["Visual Add"] = "<C-n>",
        ["Switch Mode"] = "v",
      }
    end
  },
  { "AndrewRadev/splitjoin.vim" },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return {"treesitter", "indent"}
        end
      })
    end
  },
  {
    'luukvbaal/statuscol.nvim',
    opts = function()
      local builtin = require('statuscol.builtin')
      return {
        setopt = true,
        -- override the default list of segments with:
        -- number-less fold indicator, then signs, then line number & separator
        segments = {
          { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
          { text = { '%s' }, click = 'v:lua.ScSa' },
          {
            text = { builtin.lnumfunc, ' ' },
            condition = { true, builtin.not_empty },
            click = 'v:lua.ScLa',
          },
        },
      }
    end,
  },

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
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
      },
    },
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "copilot",
      providers = {
        copilot = {
          model = "gpt-4.1", -- your desired model (or use gpt-4o, etc.)
          extra_request_body = {
            timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
            temperature = 0.75,
            max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
            --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          },
        },
      },
      selector = {
        provider = "telescope", -- or "file_selector" for file selector
      },
      windows = {
        input = {
          prefix = '»',
          height = 8,
        },
        ask = { 
          start_insert = false,
        }
      }
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
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
  },
  {
    "szw/vim-maximizer",
    keys = {
      { "<C-f>", "<cmd>MaximizerToggle<CR>", desc = "Toggle maximize split" },
    }
  },
})
