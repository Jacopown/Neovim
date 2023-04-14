return{
  {
    'hrsh7th/nvim-cmp',
    -- pin = ture,
    dependencies = {
        'neovim/nvim-lspconfig',
      { 'hrsh7th/cmp-nvim-lsp', --[[ pin = ture, ]] },
      { 'hrsh7th/cmp-buffer', --[[ pin = true, ]] },
      { 'hrsh7th/cmp-path', --[[ pin = true, ]] },
      { 'hrsh7th/cmp-cmdline', --[[ pin = true, ]] },
      { 'hrsh7th/cmp-emoji', --[[ pin = true, ]] },
      { 'kdheepak/cmp-latex-symbols', --[[ pin = true, ]] },
      { 'hrsh7th/cmp-nvim-lua', --[[ pin = true, ]] },
      { 'saadparwaiz1/cmp_luasnip', --[[ pin = ture, ]] },
    },
    config = function ()
      local cmp_ok, cmp = pcall(require, "cmp")
      if not cmp_ok then
        vim.notify("There was a problem while requiring cmp plugin")
      end

      local luasnip_ok, luasnip = pcall(require, "luasnip")
      if not luasnip_ok then
        vim.notify("There was a problem while requiring luasnip plugin")
      end

      local cmp_action = require('lsp-zero').cmp_action()

      local kind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = ""
      }
      cmp.setup {
        enabled = function()
          -- disable completion in comments
          local context = require 'cmp.config.context'
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
          end
        end,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        }),
        sources = {
          { name = 'nvim_lua' },
          { name = 'path' },
          { name = 'emoji' },
          { name = 'latex_symbols', option = { strategy = 2, }, },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
        },
        view = {
          entries = {
            name = 'custom',
            selection_order = 'near_cursor' }
        },
        formatting = {
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[NvimLua]",
              latex_symbols = "[LaTeX]",
              path = '[Path]',
              cmdline = '[CmdLine]',
              emoji = '[Emoji]'
            })[entry.source.name]
            return vim_item
          end
        },
        experimental = {
          ghost_text = true,
        },
      }

      cmp.setup.cmdline('/', { mapping = cmp.mapping.preset.cmdline(), })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = {}
            }
          }
        })
      })
    end
  },
  {
    'L3MON4D3/LuaSnip',
    -- pin = ture,
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        -- pin = true,
      },
    },
    build = 'make install_jsregexp',
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}