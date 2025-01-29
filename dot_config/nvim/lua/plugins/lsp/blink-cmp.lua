return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },
	-- use a release tag to download pre-built binaries
	version = "v0.*",
	-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',
	config = function()
		require("blink-cmp").setup({
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- see the "default configuration" section below for full documentation on how to define
			-- your own keymap.
			keymap = { preset = "default" },
			-- Experimental signature help support
			completion = {
				documentation = {
					-- Controls whether the documentation window will automatically show when selecting a completion item
					auto_show = true,
					-- Delay before showing the documentation window
					auto_show_delay_ms = 250,
					-- Delay before updating the documentation window when selecting a new item,
					-- while an existing item is still visible
					update_delay_ms = 50,
					-- Whether to use treesitter highlighting, disable if you run into performance issues
					treesitter_highlighting = true,
					window = {
						min_width = 10,
						max_width = 60,
						max_height = 20,
						border = "rounded",
						winblend = 0,
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
						-- Note that the gutter will be disabled when border ~= 'none'
						scrollbar = true,
						-- Which directions to show the documentation window,
						-- for each of the possible menu window directions,
						-- falling back to the next direction when there's not enough space
						direction_priority = {
							menu_north = { "e", "w", "n", "s" },
							menu_south = { "e", "w", "s", "n" },
						},
					},
				},
				-- Displays a preview of the selected item on the current line
				ghost_text = {
					enabled = true,
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
				kind_icons = {
					Copilot = "",
				},
			},

			-- default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, via `opts_extend`
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer", "copilot" },
				-- optionally disable cmdline completions
				-- cmdline = {},
				cmdline = function()
					local type = vim.fn.getcmdtype()
					-- Search forward and backward
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					-- Commands
					if type == ":" then
						return { "cmdline" }
					end
					return {}
				end,
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
						opts = {
							max_completions = 3,
							max_attempts = 4,
						},
					},
				},
			},
		})
	end,
	opts = {},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" },
}
