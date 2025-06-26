{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.nvf.lib.nvim.dag) entryAnywhere;
  fromGitHub = ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = lib.strings.sanitizeDerivationName repo;
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        rev = ref;
        allRefs = true;
      };
    };
in {
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
        treesitter = {
          enable = true;
          autotagHtml = true;
        };
        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          nix = {
            enable = true;
            format.enable = true;
            lsp.enable = true;
          };
          markdown = {
            enable = true;
            extensions.render-markdown-nvim = {
              enable = true;
            };
          };
          clang = {
            enable = true;
            lsp.enable = true;
          };
          bash.enable = true;
          lua.enable = true;
          tailwind.enable = true;
          css.enable = true;
          ts = {
            enable = true;
            lsp.enable = true;
          };
          html = {
            enable = true;
            treesitter.autotagHtml = true;
          };
          rust.enable = true;
        };
        visuals = {
          highlight-undo.enable = true;
          nvim-web-devicons = {
            enable = true;
            setupOpts = {
              override = {
                c = {
                  icon = "";
                  color = "#519ABA";
                  name = "C";
                };
                makefile = {
                  icon = "Ⓜ";
                  color = "#FF9D23";
                  name = "Makefile";
                };
              };
            };
          };
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
                offsets = [
                  {
                    filetype = "neo-tree";
                    highlight = "Directory";
                    separator = true;
                    text = "File Explorer";
                    text_align = "center";
                  }
                ];
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
          mappings.next = "<Down>";
          mappings.previous = "<Up>";
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
        #   obsidian = {
        #     enable = true;
        #     setupOpts = {
        #       completion.nvim_cmp = true;
        #       workspaces = [
        #         {
        #           name = "braincell";
        #           path = "~/knakto/vaults/braincell";
        #         }
        #         {
        #           name = "work";
        #           path = "~/knakto/vaults/work";
        #         }
        #       ];
        #       mappings = {
        #         "gf" = ''
        #           action = function()
        #               return require("obsidian").util.gf_passthrough()
        #           end,
        #           opts = { noremap = false, expr = true, buffer = true },'';
        #         "<leader>ch" = ''
        #           action = function()
        #             return require("obsidian").util.toggle_checkbox()
        #           end,
        #           opts = { buffer = true },'';
        #         "<cr>" = ''
        #           action = function()
        #             return require("obsidian").util.smart_action()
        #           end,
        #           opts = { buffer = true, expr = true },'';
        #       };
        #     };
        #   };
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = true;
          todo-comments.enable = true;
        };
        keymaps = [
          {
            key = "<leader>oe";
            mode = ["n" "v"];
            action = ":ObsidianTemplate<CR>";
            silent = true;
            desc = "obsidian template";
          }
          {
            key = "<leader>of";
            mode = ["n" "v"];
            action = ":s/\\(#\\)[^_]*_/\\1/ | s/-/ /g<CR>";
            silent = true;
            desc = "format obsidian note";
          }
          {
            key = "<leader>os";
            mode = ["n" "v"];
            action = ":ObsidianSearch<CR>";
            silent = true;
            desc = "search obsidian note";
          }
          {
            key = "<leader>or";
            mode = ["n" "v"];
            action = ":ObsidianRename<CR>";
            silent = true;
            desc = "rename obsidian note";
          }
          {
            key = "<leader>oi";
            mode = ["n" "v"];
            action = ":ObsidianPasteImg<CR>";
            silent = true;
            desc = "obsidian paste image";
          }
          {
            key = "<leader>ow";
            mode = ["n" "v"];
            action = ":ObsidianWorkspace<CR>";
            silent = true;
            desc = "open obsidian workspace";
          }
          {
            key = "<leader>op";
            mode = ["n" "v"];
            action = ":ObsidianOpen<CR>";
            silent = true;
            desc = "close obsidian note";
          }
          {
            key = "<leader>oo";
            mode = ["n" "v"];
            action = ":ObsidianQuickSwitch<CR>";
            silent = true;
            desc = "open obsidian quick switch";
          }
          {
            key = "<leader>oll";
            mode = ["v"];
            action = ":ObsidianLink<CR>";
            silent = true;
            desc = "insert obsidian link";
          }
          {
            key = "<leader>oln";
            mode = ["v"];
            action = ":ObsidianLinkNew<CR>";
            silent = true;
            desc = "new obsidian link";
          }
          {
            key = "<leader>oll";
            mode = ["n"];
            action = ":obsidianFollowLink<CR>";
            silent = true;
            desc = "insert obsidian link";
          }
          {
            key = "<leader>oln";
            mode = ["n"];
            action = ":ObsidianFollowLink<CR>";
            silent = true;
            desc = "new obsidian link";
          }
          {
            key = "<leader>olm";
            mode = ["n" "v"];
            action = ":ObsidianLinks<CR>";
            silent = true;
            desc = "open manage obsidian links";
          }
          {
            key = "<leader>on";
            mode = ["n"];
            action = ":ObsidianNew<CR>";
            silent = true;
            desc = "new obsidian note";
          }
          {
            key = "<leader>om";
            mode = ["n"];
            action = ":ObsidianNewFromTemplate<CR>";
            silent = true;
            desc = "new obsidian note from template";
          }
          {
            key = "<leader>ot";
            mode = ["n"];
            action = ":ObsidianTag<CR>";
            silent = true;
            desc = "insert obsidian tag";
          }
          {
            key = "<C-n>";
            mode = ["n"];
            action = ":Neotree toggle<CR>";
            silent = true;
            desc = "toggle neo-tree";
          }
          {
            key = "<C-h>";
            mode = ["n" "i" "v"];
            action = "<C-w>h";
            silent = true;
            desc = "move to window left";
          }
          {
            key = "<C-j>";
            mode = ["n" "i" "v"];
            action = "<C-w>j";
            silent = true;
            desc = "move to window down";
          }
          {
            key = "<C-k>";
            mode = ["n" "i" "v"];
            action = "<C-w>k";
            silent = true;
            desc = "move to window up";
          }
          {
            key = "<C-l>";
            mode = ["n" "i" "v"];
            action = "<C-w>l";
            silent = true;
            desc = "move to window right";
          }
          {
            key = "<leader>bd";
            mode = ["n" "v"];
            action = "<leader>bd";
            silent = true;
            desc = "delete window";
          }
          {
            key = "<C-C>";
            mode = ["v"];
            action = ''"+y'';
            silent = true;
            desc = "copy to clipboard";
          }
          {
            key = "bd";
            mode = ["n"];
            action = ":bd<CR>";
            silent = true;
            desc = "Delete window";
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
          vim.opt.conceallevel = 2
          vim.opt.backspace = { 'indent', 'eol', 'start' }
          vim.opt.listchars = { space = '⋅', tab = '→ ', eol = '↴' }
        '';
        extraPlugins = with pkgs.vimPlugins; {
          # copilot-vim = {
          #   package = copilot-vim;
          #   setup = ''
          #     --require('copilot').setup {}
          #     vim.keymap.set('i', '<m-l>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
          #     vim.g.copilot_no_tab_map = true
          #     vim.g.copilot_assume_mapped = true
          #     vim.g.copilot_cr_tab_map = true
          #   '';
          # };
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
          # neogit = {
          #   package = neogit;
          #   setup = ''vim.keymap.set("n", '<C-g>', ":Neogit<CR>", { desc = "Neogit" })'';
          # };
          oxocarbon-nvim = {
            package = oxocarbon-nvim;
            setup = ''
              vim.cmd('colorscheme oxocarbon')
            '';
          };
          smear-cursor-nvim = {
            package = smear-cursor-nvim;
            setup = ''
              require('smear_cursor').setup({
              opts = {
                stiffness = 0.8,
                trailing_stiffness = 0.6,
                distance_stop_animating = 1,
                hide_target_hack = false,
                legacy_computing_symbols_support = true,
                cterm_bg = 235,
                smear_insert_mode = false,
                },
              })
            '';
          };
          smooth-cursor-nvim = {
            package = fromGitHub "12518b284e1e3f7c6c703b346815968e1620bee2" "gen740/SmoothCursor.nvim";
            setup = ''
              require('smoothcursor').setup({
                cursor = "▷",
                fancy = {
                 enable = true,
                 head = { cursor = "", texthl = "SmoothCursor", linehl = nil }, -- false to disable fancy head
                 body = {
              	{ cursor = "󰝥", texthl = "SmoothCursorRed" },
              	{ cursor = "󰝥", texthl = "SmoothCursorOrange" },
              	{ cursor = "●", texthl = "SmoothCursorYellow" },
              	{ cursor = "●", texthl = "SmoothCursorGreen" },
              	{ cursor = "•", texthl = "SmoothCursorAqua" },
              	{ cursor = ".", texthl = "SmoothCursorBlue" },
              	{ cursor = ".", texthl = "SmoothCursorPurple" },
                },
                tail = { cursor = nil, texthl = "SmoothCursor" } -- false to disable fancy tail,
              },
              speed = 50,
               })
            '';
          };
          header_42 = {
            package = fromGitHub "9e816c72712ac72aa576b18a14a5427578c90ff7" "Diogo-ss/42-header.nvim";
            setup = ''
              require('42header').setup({
                   default_map = true,
                   auto_update = true,
                   user = "knakto",
                   mail = "knakto@student.42bangkok.com",
              });
            '';
          };
          fugitive = {
            package = vim-fugitive;
          };
          conflict_marker = {
            package = conflict-marker-vim;
          };
          git_conflict = {
            package = git-conflict-nvim;
            setup = ''require('git-conflict').setup()'';
          };
          telescope_git = {
            package = telescope-git-conflicts-nvim;
            setup = ''
              require("telescope").load_extension("conflicts")
              vim.keymap.set({"n", "v", "i"}, '<C-g>', ":Telescope conflicts<CR>", { desc = "conflict" })
            '';
            # [co] = — choose ours
            # [ct] = — choose theirs
            # [cb] = — choose both
            # [c0] = — choose none
          };
          # obsidian = {
          #   package = obsidian-nvim;
          #   setup = ''
          #     require('obsidian').setup({
          #      workspaces = {
          #        {
          #          name = "braincell",
          #          path = "~/knakto/vaults/braincell",
          #        },
          #        {
          #          name = "work",
          #          path = "~/knakto/vaults/work",
          #        },
          #       },
          #       daily_notes = {
          #         -- Optional, if you keep daily notes in a separate directory.
          #         folder = "notes/dailies",
          #         -- Optional, if you want to change the date format for the ID of daily notes.
          #         date_format = "%Y-%m-%d",
          #         -- Optional, if you want to change the date format of the default alias of daily notes.
          #         alias_format = "%B %-d, %Y",
          #         -- Optional, default tags to add to each new daily note created.
          #         default_tags = { "daily-notes" },
          #         -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
          #         template = nil
          #       },
          #       templates = {
          #         folder = "templates",
          #         date_format = "%Y-%m-%d",
          #         time_format = "%H:%M",
          #         -- A map for custom variables, the key should be the variable and the value a function
          #         substitutions = {},
          #       },
          #       open_app_foreground = false,
          #       sort_by = "modified",
          #       sort_reversed = true,
          #       disable_frontmatter = true,
          #       ---@param title string|?
          #       ---@return string
          #       note_id_func = function(title)
          #       local suffix = ""
          #       if title ~= nil then
          #       suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          #       else
          #       -- If title is nil, just add 4 random uppercase letters to the suffix.
          #       for _ = 1, 4 do
          #       suffix = suffix .. string.char(math.random(65, 90))
          #       end
          #       end
          #       -- return tostring(os.time()) .. "-" .. suffix
          #       return tostring(os.date("%d%m")) .. "-" .. tostring(os.date("%H%M")) .. "-" .. tostring(os.date("%S"))
          #       end,
          #     })
          #   '';
          # };
          neoscroll = {
            package = neoscroll-nvim;
            setup = ''
              require('neoscroll').setup()
            '';
          };
        };
      };
    };
  };
}
