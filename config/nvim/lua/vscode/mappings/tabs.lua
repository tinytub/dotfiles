local nremap = require('vscode.mappings.utils').nremap

nremap(']t', 'workbench.action.nextEditorInGroup')
nremap('[t', 'workbench.action.previousEditorInGroup')
nremap('[T', 'workbench.action.firstEditorInGroup')
nremap(']T', 'workbench.action.lastEditorInGroup')
nremap('gt', 'workbench.action.quickOpen')
