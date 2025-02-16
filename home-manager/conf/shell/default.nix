{self, ...}: {
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
      vpn-on = "sudo openvpn --config ~/knakto/Nix/public/knakto.ovpn --daemon";
      vpn-off = ''sudo kill $(ps aux | grep openvpn | awk '$1 == "root" {print $2}')'';
      develop = "nix develop --command zsh";
      fran = "~/francinette/tester.sh";
      oo = "cd ~/vaults/";
      or = "vim ~/vaults/";

      #temp
      token = ''
        curl -X POST "https://api51000.jibcom.dev/internal-login/api/v1/login" -H "Content-Type: application/json" -d '{"username":"sale001", "password":"123456"}'| jq -r | grep token | awk -F'"' '{print $4}' | wl-copy
      '';
      jib = "/home/knakto/knakto/Nix/home-manager/conf/shell/api.sh";
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
        #"tmux"
        "vi-mode"
        "yarn"
        "zsh-navigation-tools"
        "mix"
      ];
    };
  };
}
