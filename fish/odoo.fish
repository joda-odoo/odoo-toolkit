function fetch_dev -d "Fetch branch from dev remote"
	if test -e ./.git
		echo "Branch: "
		read branch
		git fetch dev $branch
		git checkout $branch
	end
end

function edit_odoo
	set out (ls ~/src | fzf)
	code ~/src/$out/odoo.code-workspace
end

function delete_db
	set out (psql -c "\l" | grep "odoo" | cut -d " " -f 2 | fzf)
	
	psql -c "drop database \"$out\";"
	echo -e "\n"
end

function fetch_odoo
	echo -e "\n\033[33m[+] \033[0mRebasing..."
	for dir in (ls ~/src)
		git -C ~/src/$dir/odoo fetch origin
       		git -C ~/src/$dir/enterprise fetch origin
   
       		if test "$dir" = "master" 
           		set branch master
       		else
           		set branch $dir.0
		end
   
       		git -C ~/src/$dir/odoo rebase origin/$branch
       		git -C ~/src/$dir/enterprise rebase origin/$branch 
	end
	echo -e "\n\033[32m[+] \033[0mDONE !"
end

function select_module --argument odoo_path
	set odoo_apps (grep -rnw ~/src/$odoo_path -e "'application': True" | cut -d : -f 1)
	set app_lst ""
	set cmd ""

	for apps in $odoo_apps
		set app_name (cat $apps | python -c "import sys;d=eval(sys.stdin.read()); print(d['name'])")
		set app_id (basename (dirname $apps))
		set -a app_lst "$app_name - $app_id\n"
	end

	set choice (echo -e $app_lst | fzf -m)
	
	for c in $choice
		echo -n (echo $c | cut -d "-" -f 2 | cut -d " " -f 2),
	end
end

function init_odoo
	set out (ls ~/src | fzf)
	set module (select_module $out)
	source ~/.env/odoo-(basename $out)/bin/activate.fish
	ODOO_WORKSPACE=~/src/$out ~/src/.patches/main.py --init base,$module --addons="~/src/$out/odoo/addons,~/src/$out/enterprise" -d odoo-(basename $out)
	deactivate
end

function run_odoo
	set out (ls ~/src | fzf)
	source ~/.env/odoo-(basename $out)/bin/activate.fish

	ODOO_WORKSPACE=~/src/$out ~/src/.patches/main.py --addons="~/src/$out/odoo/addons,~/src/$out/enterprise" -d odoo-(basename $out)
	deactivate
end

function goto_odoo
	set out (ls ~/src | fzf)
	source ~/.env/odoo-(basename $out)/bin/activate.fish
	cd ~/src/$out/odoo
end

function goto_enterprise
	set out (ls ~/src | fzf)
	source ~/.env/odoo-(basename $out)/bin/activate.fish
	cd ~/src/$out/enterprise
end

bind \ee edit_odoo
bind \eb fetch_dev
bind \ef delete_db
bind \eu fetch_odoo 
bind \ei init_odoo
bind \er run_odoo
bind \eo goto_odoo
bind \ep goto_enterprise
