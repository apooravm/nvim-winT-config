local builtin = require("statuscol.builtin")
require("statuscol").setup({
	-- configuration goes here, for example:
	relculright = true,
	-- Default segments (fold -> sign -> line number + separator),
	-- mine - sign -> fold -> line num + separator
	segments = {
		{ text = { "%s" }, click = "v:lua.ScSa" },
		{ text = { builtin.foldfunc }, click = "v:lua.ScFa", colwidth = 2 },
		-- " " is the separator
		{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
	},
})
