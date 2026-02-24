{ config, pkgs, home-manager, ... }:
{
  programs.git = { 
		enable = true;
		settings = {
			core = {
				abbrev = 10;
				editor = "vim";
				pager = "bat";
				autocrlf = false;
			};
			init.defaultBranch = "main";
			color.ui = "auto";
			diff = {
				color = "always";
				algorithm = "histogram";
				renames = "copies";
				colorMoved = "default";
				wsErrorHighlight = "all";
			};
			web.browser = "firefox";
			branch.autoSetupMerge = "always";
			rerere.enabled = true;
			stash.showPatch = true;
			status = { 
				short = true; 
				branch = true; 
			};
	  	tag.sort = "version:refname";
			log = { 
				color = "always"; 
				date = "iso"; 
			};
			gc = { 
				pruneExpire = "1.weeks.ago"; 
				worktreePruneExpire = "1.month.ago"; 
			};
	  	grep.lineNumber = true;
	  	help.autoCorrect = 20;
      alias = {
        co = "checkout";
        ci = "commit";
        cia = "commit --amend -C@";
        st = "!f() { echo ''; git status -s $@; echo ''; }; f";
        last = "log -1 HEAD";
        lg = "log --graph --pretty=format:'%Cred%h%Creset %C(yellow)%an%d%Creset %s %Cgreen(%cr)%Creset' --date=relative";
        dc = "diff --cached";
        bdiff = "!f() { git --no-pager diff --name-only --relative --diff-filter=d | xargs bat --diff; }; f";
        unstage = "reset HEAD --";
        undo = "reset --soft HEAD@{1}";
        up = "!git pull origin \"$(git rev-parse --abbrev-ref HEAD)\"";
        pb = "!git push origin \"$(git rev-parse --abbrev-ref HEAD)\"";
        pbu = "!git push --set-upstream origin \"$(git rev-parse --abbrev-ref HEAD)\"";
        dmerged = "!git branch --merged | egrep -v \"(^\\*|master|dev)\" | xargs git branch -d";
        subup = "!(git submodule sync; git submodule update --init --recursive;)";
        tg = "!git log --tags --simplify-by-decoration --pretty=\"format:[%ai] %C(yellow)%H%Creset - %Cgreen%D%Creset\"";
      };
    };
  };
}
