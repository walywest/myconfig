{config, ...}:
{
  programs.zsh = {
	  enable = true;
	  enableCompletion = true;
	  autosuggestions.enable = true;
	  syntaxHighlighting.enable = true;
	  #initExtra = "eval '$(zoxide init zsh)'";

	  shellAliases = {
	    ll = "ls -l";
	    # update = "sudo nixos-rebuild switch";
	    # conf = "sudo nvim /etc/nixos/configuration.nix";
	    hardclean = "sudo nix-collect-garbage; sudo nix-collect-garbage -d; update";
	  };
	  histSize = 10000;
	  ohMyZsh = { enable = true; plugins = [ "git" ]; theme = "robbyrussell";
	  };
	};
}
