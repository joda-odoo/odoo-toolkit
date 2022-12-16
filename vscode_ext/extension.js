const vscode = require('vscode');

/**
 * @param {vscode.ExtensionContext} context
 */
function activate(context) {
	// let disposable = vscode.commands.registerCommand('odoo-toolkit.byeWorld', function () {
	// 	vscode.window.showInformationMessage('Hello World from odoo-toolkit!');
	// });

	// context.subscriptions.push(disposable);

	context.subscriptions.push(
		vscode.commands.registerCommand('odoo-toolkit.findInherit', function() {
			vscode.window.showInputBox({
				placeHolder: "Model name (res.users)"
			}).then((model) => vscode.commands.executeCommand(
				"workbench.action.findInFiles", 
				{
					query: `^( +)?_inherit ?= ?\\[?((("|')[a-z]+("|'), ?)?)+("|')${model}("|')((, ?("|')[a-z]+("|'))?)+\\]?`,
					triggerSearch: true,
				}
			))
		},

		vscode.commands.registerCommand('odoo-toolkit.findModel', function() {
			vscode.window.showInputBox({
				placeHolder: "Model name (res.users)"
			}).then((model) => vscode.commands.executeCommand(
				"workbench.action.findInFiles", 
				{
					query: `^( +)?_name ?= ?("|')${model}("|')`,
					triggerSearch: true,
				}
			))
		})
	));
}

function deactivate() {}

module.exports = {
	activate,
	deactivate
}
