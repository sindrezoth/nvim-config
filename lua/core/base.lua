-- vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"

vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
	virtual_text = false, -- Show virtual text for diagnostics
	signs = true, -- Show signs in the gutter
	underline = true, -- Underline errors and warnings
	update_in_insert = false, -- Don't update diagnostics while typing
	severity_sort = true, -- Sort by severity
	float = {
		border = "rounded",
	},
})

vim.keymap.set("n", "gK", function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.fileencoding = "utf-8"

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"
vim.opt.wildignore:append({ "**node_modules**" })

vim.opt.swapfile = false

vim.g.mapleader = " "

-- vim.opt.wildcard ???

-- vim.opt.langmap
-- vim.opt.langremap = true
--
--	Example (for Greek, in UTF-8):				*greek*  >vim
--	    set langmap=ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz
--<	Example (exchanges meaning of z and y for commands): >vim
--	    set langmap=zy,yz,ZY,YZ
--<
--	The 'langmap' option is a list of parts, separated with commas.  Each
--	part can be in one of two forms:
--	1.  A list of pairs.  Each pair is a "from" character immediately
--	    followed by the "to" character.  Examples: "aA", "aAbBcC".
--	2.  A list of "from" characters, a semicolon and a list of "to"
--	    characters.  Example: "abc;ABC"
--	Example: "aA,fgh;FGH,cCdDeE"
--	Special characters need to be preceded with a backslash.  These are
--	";", ',', '"', '|' and backslash itself.
--
--	This will allow you to activate vim actions without having to switch
--	back and forth between the languages.  Your language characters will
--	be understood as normal vim English characters (according to the
--	langmap mappings) in the following cases:
--	 o Normal/Visual mode (commands, buffer/register names, user mappings)
--	 o Insert/Replace Mode: Register names after CTRL-R
--	 o Insert/Replace Mode: Mappings
--	Characters entered in Command-line mode will NOT be affected by
--	this option.   Note that this option can be changed at any time
--	allowing to switch between mappings for different languages/encodings.
--	Use a mapping to avoid having to type it each time!
