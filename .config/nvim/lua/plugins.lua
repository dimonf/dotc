local M = {}


function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
        vim.notify = require "notify"
      end,
    }

    -- Colorscheme
    use {
      "sainnhe/everforest",
      config = function()
        vim.cmd "colorscheme everforest"
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Better Netrw
    use { "tpope/vim-vinegar", disable = true }

    -- Git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      config = function()
        require("config.neogit").setup()
      end,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      disable = false,
      event = "VimEnter",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
      disable = true,
    }

    -- Better surround
    use { "tpope/vim-surround", event = "InsertEnter" }

    -- Motions
    use { "andymass/vim-matchup", event = "CursorMoved" }
    use { "wellle/targets.vim", event = "CursorMoved" }
    use { "unblevable/quick-scope", event = "CursorMoved", disable = true}
    use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" }, disable = true }

    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
      disable = true,
    }

    use {
      "ggandor/lightspeed.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        require("lightspeed").setup {}
      end,
      disable = true,
    }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    }

    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup()
      end,
      --wants = "nvim-web-devicons",
      requires = "nvim-web-devicons",
    }

    -- replacement for nvim-gps:
    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }

    --[[
    use {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      disable = true,
      module = "nvim-gps",
      wants = "nvim-treesitter",
      config = function()
        require("nvim-gps").setup()
      end,
    }
    --]]

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
    }

    -- FZF
    -- use { "junegunn/fzf", run = "./install --all", event = "VimEnter" } -- You don't need to install this if you already have fzf installed
    -- use { "junegunn/fzf.vim", event = "BufEnter" }

    -- FZF Lua
    use {
      "ibhagwan/fzf-lua",
      event = "BufEnter",
      --wants = "nvim-web-devicons",
      requires = "nvim-web-devicons",
    }

    -- nvim-tree
    use {
      "kyazdani42/nvim-tree.lua",
      --wants = "nvim-web-devicons",
      requires = "nvim-web-devicons",
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      --wants = "nvim-web-devicons",
      config = function()
        require("config.bufferline").setup()
      end,
      disable = true,
    }

    -- User interface
    use {
      "stevearc/dressing.nvim",
      event = "BufEnter",
      config = function()
        require("dressing").setup {
          select = {
            backend = { "telescope", "fzf", "builtin" },
          },
        }
      end,
      disable = true,
    }

    use { "nvim-telescope/telescope.nvim", module = "telescope", as = "telescope" }

    -- Completion
    --[[
    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      event = "VimEnter",
      opt = true,
      run = ":COQdeps",
      config = function()
        require("config.coq").setup()
      end,
      requires = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
      },
      disable = true,
    }
    ]]


    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      -- wants = "nvim-treesitter",
      requires = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- Auto tag
    use {
      "windwp/nvim-ts-autotag",
      disable = true,
      -- wants = "nvim-treesitter",
      requires = "nvim-treesitter",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      -- wants = "nvim-treesitter",
      requires = "nvim-treesitter",
      event = "InsertEnter",
      disable = false,
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "ray-x/lsp_signature.nvim",
        "cmp-nvim-lsp",
      },
      after = {"mason.nvim","mason-lspconfig.nvim" },
    }

    use {
       "williamboman/mason-lspconfig.nvim",
       config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "ansiblels",
            "bashls",
            "dockerls",
            "sumneko_lua",
          }
        })
      end,
      after = "mason.nvim",
    }

    use {
      "williamboman/mason.nvim" ,
      config = function()
        require("config.mason").setup()
        --require("mason").setup()
      end,
    }

    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use {'cmp_buffer', disable = true}
    use {'cmp-path', disable = true}
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'rafamadriz/friendly-snippets'

    use {
      "ray-x/lsp_signature.nvim",
      config = function()
        require ("lsp_signature").setup({
          bind = true,
          handler_opts = {
            border = "rounded",
          },
        })
      end,
    }

    -- last edit file
    use {
      'ethanholz/nvim-lastplace',
      config = function()
        require'nvim-lastplace'.setup {
            lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
            lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
            lastplace_open_folds = true
      }
      end,
    }

    use {
      'godlygeek/tabular',
      config = {}
    }

    use {
      'nathangrigg/vim-beancount',
      config = {}
    }

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
