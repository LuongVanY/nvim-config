local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- lsp
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "jay-babu/mason-nvim-dap.nvim" },

      -- null-ls
      { "nvimtools/none-ls.nvim" },
      { "jay-babu/mason-null-ls.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      -- Snippets
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = "make install_jsregexp"
      },
      { "rafamadriz/friendly-snippets" },
      { "honza/vim-snippets" },
    },
  },

  -- nice to have
  { "numToStr/Comment.nvim" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "nvim-treesitter/nvim-treesitter",            build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-context" },

  -- navigation
  {
    "kyazdani42/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  { "ThePrimeagen/harpoon" },
  { "nvim-telescope/telescope.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- git
  { "kdheepak/lazygit.nvim" },
  { "airblade/vim-gitgutter" },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "nvim-telescope/telescope-dap.nvim" },

  -- misc
  { "kevinhwang91/nvim-bqf",                    ft = "qf" },
  { "mbbill/undotree" },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
  },
  { "uga-rosa/ccc.nvim" },
  { "nvim-pack/nvim-spectre" },
  { "kylechui/nvim-surround" },
  { "nycrat/todo.nvim" },

  -- looks
  {
    "folke/noice.nvim",
    dependencies = { { "MunifTanjim/nui.nvim" }, { "rcarriga/nvim-notify" }, { "nvim-lua/plenary.nvim" } },
  },
  { "laytan/cloak.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "xiyaowong/nvim-transparent" },
  { "karb94/neoscroll.nvim" },
  { "f-person/git-blame.nvim" },
  { "projekt0n/caret.nvim" },
  -- LSP Ui
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'     -- optional
    }
  },
  -- Tag
  { "windwp/nvim-ts-autotag" },
  { "onsails/lspkind.nvim" },
  {
    "hrsh7th/nvim-cmp" ,
    lazy = true,

  },
  -- Tab
  { "nanozuki/tabby.nvim" },
  -- tabbar
  { "preservim/tagbar"},
  { "liuchengxu/vista.vim"},
  {
    "lukas-reineke/indent-blankline.nvim", 
    main = "ibl",
    opts = {},
    setup = function (_, opts)
      require("ibl").setup()
    end,
  }
})
