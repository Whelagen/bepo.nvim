local cmd = vim.cmd

local undercursor = function()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	return vim.api.nvim_get_current_line():sub(col + 1, col + 1)
end

-- Fonction pour les mapping passant par lua
local map = function(mode, lhs, rhs, opt)
	local options = { noremap = true, silent = true }
	if opt then
		options = vim.tbl_extend("force", options, opt)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- {W} -> [É]
-- ——————————
-- On remappe W sur É :
map("n", "é", "w")
map("n", "É", "W")

--  Corollaire: on remplace les text objects aw, aW, iw et iW
--  pour effacer/remplacer un mot quand on n’est pas au début (daé / laé).
map("o", [[aé]], [[aw]])
map("o", [[aÉ]], [[aW]])
map("o", [[ié]], [[iw]])
map("o", [[iÉ]], [[iW]])

-- Pour faciliter les manipulations de fenêtres, on utilise {W} comme un Ctrl+W :
map("n", "w", "<C-w>") -- noremap w <C-w>
map("n", "W", "<C-w><C-w>") -- noremap W <C-w><C-w>

-- [HJKL] -> {CTSR}
-- ————————————————
-- {cr} = « gauche / droite »
map("n", "c", "h") -- noremap c h
map("n", "r", "l") -- noremap r l
-- {ts} = « haut / bas »
map("n", "t", "j") -- noremap t j
map("n", "s", "k") -- noremap s k
-- {CR} = « haut / bas de l'écran »
map("n", "C", "H") -- noremap C H
map("n", "R", "L") -- noremap R L
-- {TS} = « joindre / aide »
map("n", "T", "J") -- noremap T J
map("n", "S", "K") -- noremap S K

-- {cr} = « gauche / droite »
map("v", "c", "h") -- noremap c h
map("v", "r", "l") -- noremap r l
-- {ts} = « haut / bas »
map("v", "t", "j") -- noremap t j
map("v", "s", "k") -- noremap s k
-- {CR} = « haut / bas de l'écran »
-- map('v', 'C', 'H') -- noremap C H
-- map('v', 'R', 'L') -- noremap R L
-- -- {TS} = « joindre / aide »
-- map('v', 'T', 'J') -- noremap T J
-- map('v', 'S', 'K') -- noremap S K
-- Corollaire : repli suivant / précédent
map("n", "zs", "zj") -- noremap zs zj
map("n", "zt", "zk") -- noremap zt zk

-- {HJKL} <- [CTSR]
--  ————————————————
-- " {J} = « Jusqu'à »            (j = suivant, J = précédant)
map("n", "j", "t") -- noremap j t
map("n", "J", "T") -- noremap J T
-- " {L} = « Change »             (l = attend un mvt, L = jusqu'à la fin de ligne)
map("n", "l", "c") -- noremap l c
map("n", "L", "C") -- noremap L C
-- " {H} = « Remplace »           (h = un caractère slt, H = reste en « Remplace »)
map("n", "h", "r") -- noremap h r
map("n", "H", "R") -- noremap H R
-- " {K} = « Substitue »          (k = caractère, K = ligne)
map("n", "k", "s") -- noremap k s
map("n", "K", "S")
-- " Corollaire : correction orthographique
map("n", "]k", "]s") -- noremap ]k ]s
map("n", "[k", "[s") -- noremap [k [s

-- Désambiguation de {g}
--" —————————————————————
--" ligne écran précédente / suivante (à l'intérieur d'une phrase)
map("n", "gs", "gk") -- noremap gs gk
map("n", "gt", "gj") -- noremap gt gj
--" onglet précédant / suivant
map("n", "gb", "gT") -- noremap gb gT
map("n", "gé", "gt") -- noremap gé gt
--" optionnel : {gB} / {gÉ} pour aller au premier / dernier onglet
map("n", "gB", ':exe "silent! tabfirst"<CR>') --
map("n", "gÉ", ':exe "silent! tablast"<CR>') --
--" optionnel : {g"} pour aller au début de la ligne écran
map("n", 'g"', "g0") --

--" <> en direct
--" ————————————
map("n", "«", "<") --
map("n", "»", ">") --

-- Remaper la gestion des fenêtres
--" ———————————————————————————————
map("n", "wt", "<C-w>j")
map("n", "ws", "<C-w>k")
map("n", "wc", "<C-w>h")
map("n", "wr", "<C-w>l")
map("n", "wd", "<C-w>c")
map("n", "wo", "<C-w>s")
map("n", "wp", "<C-w>o")
map("n", "w<SPACE>", ":split<CR>")
map("n", "w<CR>", ":vsplit<CR>")

-- è et ç comme raccourcis
--  ———————————————————————————————
--  en mode insertion, èè → normal
map("i", "èè", "<ESC>")
-- " en mode normal, èè → insertion
map("n", "èè", ":startinsert<cr>")
-- " en mode visuel, èè → normal
map("v", "èè", "<ESC>")
-- " çç ⇔  Échap+:
map("n", "çç", "<ESC>:")
map("i", "çç", "<ESC>:")

map("i", "<c-e>", "<ESC>gea")
-- vim.api.nvim_del_keymap("n", "<c-e>")
-- map("i", "<c-e>", "<ESC>print(undercursor())")

--  Touche, MapLeader :
-- --  ———————————————————————————————
vim.g.mapleader = "à"
-- vim.o.mapleader = 'à'
