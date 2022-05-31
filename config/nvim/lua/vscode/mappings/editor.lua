local nremap = require('vscode.mappings.utils').nremap

nremap('gs', 'workbench.action.gotoSymbol')
nremap('gS', 'workbench.action.showAllSymbols')
nremap('<leader>ff', 'workbench.action.findInFiles')

vim.cmd([[
	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine
]])

-- error navigation
nremap('gnn', 'editor.action.marker.next')
nremap('gpp', 'editor.action.marker.prev')
nremap('gn', 'editor.action.marker.nextInFiles')
nremap('gp', 'editor.action.marker.prevInFiles')
nremap('gr', 'editor.action.goToReferences')
nremap('gi', 'editor.action.goToImplementation')
