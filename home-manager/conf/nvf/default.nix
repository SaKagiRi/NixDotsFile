{
  pkgs,
  inputs,
  ...
}:let
  inherit (inputs.nvf.lib.nvim.dag) entryAnywhere;
in{
  programs.nvf = {
    enableManpages = true; #for man 5 nvf
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        theme = {
          enable = false;
          name = "rose-pine";
          style = "moon";
        };
        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };
        lsp = {
          enable = true;
          null-ls.enable = true;
          mappings.hover = "J";
        };
        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          nix = {
            enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          markdown.enable = true;
          clang = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          bash.enable = true;
          lua.enable = true;
        };
        visuals = {
          highlight-undo.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
          cellular-automaton.enable = false;
        };
        tabline = {
          nvimBufferline = {
            enable = true;
            mappings.cycleNext = "L";
            mappings.cyclePrevious = "H";
            setupOpts = {
              options = {
                show_buffer_close_icons = false;
                indicator.style = "none";
                separator_style = "slope";
                numbers = "none";
                tab_size = 20;
                line_height = 3;
                offsets = [{
                  filetype = "neo-tree";
                  highlight = "Directory";
                  separator = true;
                  text = "File Explorer";
                  text_align = "center";
                }];
              };
            };
          };
        };
        filetree = {
          neo-tree = {
            enable = true;
            setupOpts = {
              window = {
                width = 30;
                mappings = {
                  "space" = false;
                  "l" = "open";
                  "h" = "close_node";
                  "P" = "toggle_preview";
                  "t" = "open_tabnew";
                };
              };
              enable_cursor_hijack = true;
              enable_git_status = true;
              enable_refresh_on_write = true;
              auto_clean_after_session_restore = true;
              git_status_async = true;
            };
          };
        };
        binds = {
          whichKey.enable = true;
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp = {
          enable = true;
          mappings.next = "j";
          mappings.previous = "k";
        };
        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
        };
        comments = {
          comment-nvim.enable = true;
        };
        notes = {
          obsidian.enable = false;
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = true;
          todo-comments.enable = true;
        };
        keymaps = [
          {
            key = "<C-n>";
            mode = [ "n" ];
            action = ":Neotree toggle<CR>";
            silent = true;
            desc = "toggle neo-tree";
          }
          {
            key = "<C-h>";
            mode = [ "n" "i" "v" ];
            action = "<C-w>h";
            silent = true;
            desc = "move to window left";
          }
          {
            key = "<C-j>";
            mode = [ "n" "i" "v" ];
            action = "<C-w>j";
            silent = true;
            desc = "move to window down";
          }
          {
            key = "<C-k>";
            mode = [ "n" "i" "v" ];
            action = "<C-w>k";
            silent = true;
            desc = "move to window up";
          }
          {
            key = "<C-l>";
            mode = [ "n" "i" "v" ];
            action = "<C-w>l";
            silent = true;
            desc = "move to window right";
          }
        ];
        options = {
          smartindent = true;
          expandtab = false;
          shiftwidth = 4;
          softtabstop = -1;
          tabstop = 4;
          list = true;
        };
        luaConfigRC.aerial-nvim = entryAnywhere ''
        vim.opt.backspace = { 'indent', 'eol', 'start' }
        vim.opt.listchars = { space = '⋅', tab = '→ ', eol = '↴' }
        '';
        extraPlugins = with pkgs.vimPlugins; {
          copilot-vim = {
            package = copilot-vim;
            setup = ''
               --require('copilot').setup {}
               vim.keymap.set('i', '<m-l>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
               vim.g.copilot_no_tab_map = true
               vim.g.copilot_assume_mapped = true
               vim.g.copilot_cr_tab_map = true
            '';
          };
          CopilotChat-nvim = {
            package = CopilotChat-nvim;
            setup = ''
              require("CopilotChat").setup({
                window = {
                  layout = 'float',
                  width = 0.5,
                  height = 0.5,
                  relative = 'editor',
                  border = 'single',
                  row = nil,
                  col = nil,
                  title = 'OhChat',
                  footer = nil,
                  zindex = 1,
                },
              })
              vim.keymap.set({"n", "i", "v"}, "<C-c>", ":CopilotChatToggle<CR>", { desc = "copilot" })
            '';
          };
          toggleterm-nvim = {
            package = toggleterm-nvim;
            setup = ''
              require("toggleterm").setup({
                function(term)
                  if term.direction == "horizontal" then
                    return 17
                  elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                  end
                end,
                open_mapping = [[<c-\>]],
                direction = "float",
              })
           '';
          };
          neogit = {
            package = neogit;
            setup = ''vim.keymap.set("n", '<C-g>', ":Neogit<CR>", { desc = "Neogit" })'';
          };
          oxocarbon-nvim = {
            package = oxocarbon-nvim;
             setup = ''
               vim.cmd('colorscheme oxocarbon')
            '';
          };

        };
      };
    };
  };
}
