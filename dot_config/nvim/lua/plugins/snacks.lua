return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		scroll = { enabled = true },
		bigfile = { enabled = true },
		notifier = { enabled = false },
		bufdelete = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
			preset = {
				header = [[
     =================     ===============     ===============   ========  ========
     \\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
     ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
     || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
     ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
     || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
     ||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
     || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
     ||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
     ||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
     ||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
     ||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
     ||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
     ||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
     ||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
     ||.=='    _-'                                                     `' |  /==.||
     =='    _-'                        N E O V I M                         \/   `==
     \   _-'                                                                `-_   /
     `''                                                                      ``']],
			},
		},
		-- quickfile = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
	},
}
