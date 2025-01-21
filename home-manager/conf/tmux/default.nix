{	lib
,	pkgs
,	...
}:

{
  programs.tmux = {
    enable = true;
	clock24 = true;
	shortcut = "a";
	keyMode = "vi";
    baseIndex = 1;
    newSession = true;
    escapeTime = 10;
	terminal = "xterm-256color";
    secureSocket = false;

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
	  vim-tmux-navigator
	  tmux-nova
	  cpu
    ];
    extraConfig = lib.readFile ./tmux.conf;
  };
}
