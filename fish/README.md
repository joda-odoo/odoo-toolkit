# Fish config
## Requirements

For this little setup you need:
* A copy of [huvw's patches for Odoo](https://github.com/hubvd/odoo-tools/tree/master/patches) and put it under `~/.src/.patches`
* A git-worktree with all the versions you need saved under `~/src/ODOO_VER_NUM` (ex: ~/src/16)
* Some Python virtual envs for each version you need saved under `~/.env/odoo-ODOO_VER_NUM` (ex: ~/.env/odoo-16)
* Visual studio code
* Fish (of course)
* fzf

## Keybindings
* <kbd>Alt</kbd> + <kbd>e</kbd> - Launch vscode on `~/src/ODOO_VER_NUM/odoo.code-workspace`
* <kbd>Alt</kbd> + <kbd>b</kbd> - Fetch a branch on odoo-dev (:warning: don't forget to add odoo-dev as a remote with the name **dev**) 
* <kbd>Alt</kbd> + <kbd>f</kbd> - Delete a choosen `odoo-ODOO_VER_NUM` for postgres
* <kbd>Alt</kbd> + <kbd>u</kbd> - Update every version of Odoo on your `~/src` directory
* <kbd>Alt</kbd> + <kbd>i</kbd> - Initiate a new Odoo database with the modules of your choosing
* <kbd>Alt</kbd> + <kbd>r</kbd> - Run an already initiated Odoo database
* <kbd>Alt</kbd> + <kbd>o</kbd> - Go to a odoo community worktree with venv enabled
* <kbd>Alt</kbd> + <kbd>p</kbd> - Go to an enterprise worktree with venv enabled
