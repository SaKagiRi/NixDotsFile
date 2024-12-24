{
	pkgs,
	lib,
	...
}:

{
	programs.neovim =
		let
		fromGitHub = ref: repo: pkgs.vimUtils.buildVimPlugin {
			pname = lib.strings.sanitizeDerivationName repo;
			version = ref;
			src = builtins.fetchGit {
				url = "https://github.com/${repo}.git";
				rev = ref;
			};
		};
			#toLua = str: "lua << EOF\n${str}\nEOF\n";
	in
	{
		enable = true;
		defaultEditor = true;
		plugins = with pkgs.vimPlugins; [
			#colorscheme
			(fromGitHub "4360477c3cfcd2d254cd23b9adfc0b17feea8a94" "sontungexpt/witch")
				sonokai

			#search
				neo-tree-nvim
				fzf-lua

			#language server
				{
					plugin = (nvim-treesitter.withPlugins (p: [
								p.tree-sitter-nix
								p.tree-sitter-vim
								p.tree-sitter-bash
								p.tree-sitter-lua
								p.tree-sitter-python
								p.tree-sitter-json
								p.tree-sitter-c
								p.tree-sitter-rust
					]));
				}
				telescope-nvim
				telescope-ui-select-nvim
				mason-nvim
				mason-lspconfig-nvim
				nvim-lspconfig
				null-ls-nvim

			#dependencies
				plenary-nvim
				nvim-web-devicons
				nui-nvim
				cmp_luasnip
				friendly-snippets
				diffview-nvim
				fzf-lua
				mini-pick

			#ultilitiles
				toggleterm-nvim
				neogit
				obsidian-nvim
			(fromGitHub "5726c4e291224181903e960119a11e20ac677a0a" "akinsho/bufferline.nvim")

			#completions
				cmp-nvim-lsp
				nvim-cmp
				luasnip
		];
		extraConfig = ''
			set			smartindent
			"set			autoindent
			set			noexpandtab
			set			tabstop=4
			set			shiftwidth=4
			set			backspace=indent,eol,start
			set			nu
			set			list
			set			list
			set			listchars+=space:⋅
			set			listchars+=tab:→\ 
			set			listchars+=eol:↴

			colorscheme witch-dark
			nnoremap <C-n> :Neotree toggle<CR> " --neotree
			nnoremap <C-s> :w<CR> " --save
			nnoremap <C-h> <C-w>h
			nnoremap <C-l> <C-w>l
			nnoremap <C-j> <C-w>j
			nnoremap <C-k> <C-w>k

			lua <<EOF
			vim.g.mapleader = " "
			require("nvim-web-devicons").setup({default = true,})
			require("neo-tree").setup({
				window = {
					width = 30,
					mappings = {
						["<space>"] = false,
						["[b"] = "prev_source",
						["]b"] = "next_source",
						["t"] = "open_tabnew",
						["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
						["h"] = "close_node",
						["l"] = "open",
					},
					fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
						["<C-j>"] = "move_cursor_down",
						["<C-k>"] = "move_cursor_up",
					},
				},
			})

			require('nvim-treesitter.configs').setup ({
				ensure_installed = {},
				auto_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})

			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown{}
					}
				},
				defaults = {
					mappings = {
						i = {
							["<C-h>"] = "which_key"
						}
					}
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "tepescope find_file" } )
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "tepescope live_grep" } )
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "tepescope buffers" } )
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "tepescope help" } )
			require("telescope").load_extension("ui-select")

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd", "nil_ls" },
			})
			local lspconfig = require("lspconfig")
			--lspconfig.lua_ls.setup({})
			lspconfig.clangd.setup({
				cmd = {"/home/knakto/.nix-profile/bin/clangd"}
			})
			lspconfig.nil_ls.setup({
				cmd = {"/home/knakto/.nix-profile/bin/nixd"}
			})
			vim.keymap.set("n", "J", vim.lsp.buf.hover, { desc = "hover"})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "definition" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code_action" })

			vim.opt.termguicolors = true
			require("bufferline").setup({
				options = {
					separator_style = "slope",
					always_show_bufferline = true,
					show_buffer_icons = true,
					show_buffer_close_icons = true,
					show_tab_indicators = true,
					line_height = 3,
					max_name_length = 30,
					max_prefix_length = 15,
					tab_size = 30,
					offsets = {
						{
							-- filetype = "NvimTree",
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "center",
							highlight = "Directory",
							separator = true,
							-- padding = 1,
						}
					}
				}
			})
			vim.keymap.set('n', 'L', ":BufferLineCycleNext<CR>", { desc = "nextbuffer" })
			vim.keymap.set('n', 'H', ":BufferLineCyclePrev<CR>", { desc = "nextbuffer" })
			vim.keymap.set('n', '<leader>bd', ":bd<CR>", { desc = "deletebuffer" })

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

		  local cmp = require("cmp")
		  require("luasnip.loaders.from_vscode").lazy_load()

		  cmp.setup({
			snippet = {
			  expand = function(args)
				require("luasnip").lsp_expand(args.body)
			  end,
			},
			window = {
			  completion = cmp.config.window.bordered(),
			  documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
			  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
			  ["<C-f>"] = cmp.mapping.scroll_docs(4),
			  ["<C-Space>"] = cmp.mapping.complete(),
			  ["<C-e>"] = cmp.mapping.abort(),
			  ["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
			  { name = "nvim_lsp" },
			  { name = "luasnip" }, -- For luasnip users.
			}, {
			  { name = "buffer" },
			}),
		  })

		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.nixpkgs_fmt,
				--null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.completion.spell,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "format" })

		require("fzf-lua").setup()
		vim.keymap.set("n", '<C-g>', ":Neogit<CR>", { desc = "Neogit" })

		require("obsidian").setup({
			workspaces = {
			  {
				name = "personal",
				path = "~/Documents/Obsidian",
			  },
			}
		})
		vim.opt.conceallevel = 2  -- or 2, depending on your preference
EOF
			'';
		vimAlias = true;
	};
}
