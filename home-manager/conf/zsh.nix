{ ...
}:

{

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    history = {
      ignoreDups = true;
      save = 1000000;
      size = 1000000;
    };

    shellAliases = {
      v = "nvim";
      c = "clear";
      open = "xdg-open";
      vpn-on =
        "ENABLE_VPN=true sudo --preserve-env ENABLE_VPN nixos-rebuild switch";
      vpn-off = "sudo nixos-rebuild switch";
      icat = "kitty +kitten icat";
      ls = "eza";
      la = "eza -a";
      nixhome = "home-manager switch --flake ~/knakto/Nix";
      wayland = "export XDG_SESSION_TYPE=wayland";
      x11 = "export XDG_SESSION_TYPE=x11";
      sound = "amixer set Master";
	  cd = "z";
	  cat = "bat";
	  mans = "tldr";
	  norm = "/home/knakto/.local/share/pipx/venvs/norminette/bin/norminette";
    };

    initExtra = ''
			fastfetch
			eval "$(fzf --zsh)"
			eval "$(zoxide init zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "aws"
        "docker"
        "encode64"
        "git"
        "git-extras"
        "man"
        "nmap"
        "sudo"
        "systemd"
        "tig"
        "tmux"
        "vi-mode"
        "yarn"
        "zsh-navigation-tools"
        "mix"
      ];
    };
  };
}
