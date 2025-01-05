{
	pkgs,
	...
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
	terminal = "tmux-256color";
    secureSocket = false;

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
	  vim-tmux-navigator
	  tmux-nova
	  cpu
    ];
    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      set -g prefix C-f
      set -g mouse on

      set -g base-index 1 # start window numbering at 1
      setw -g pane-base-index 1 # start pane numbering at 1

      unbind '"'
      unbind %
      bind | split-window -hc "#{pane_current_path}" # split horizontally
      bind - split-window -vc "#{pane_current_path}" # split vertically

      bind -r "<" swap-window -d -t -1 # swap with previous window
      bind -r ">" swap-window -d -t +1 # swap with next window

      bind c new-window -c "#{pane_current_path}" # keep current path when creating new window
      bind Space last-window # toggle between current and last window
      bind-key C-Space switch-client -l # switch to last session

      bind-key H select-pane -L
      bind-key J select-pane -D
      bind-key K select-pane -U
      bind-key L select-pane -R

      bind-key C-c new-session
      bind-key X kill-server
      bind-key C-x kill-session
      bind-key x kill-window
      bind-key l next-window
      bind-key h previous-window
      bind-key n last-window

      set-option -g status-position top

	  set -g @nova-nerdfonts true
	  set -g @nova-nerdfonts-left 
	  set -g @nova-nerdfonts-right 

	  set -g @nova-pane-active-border-style "#44475a"
	  set -g @nova-pane-border-style "#282a36"
	  set -g @nova-status-style-bg "#000000"
	  set -g @nova-status-style-fg "#d8dee9"
	  set -g @nova-status-style-active-bg "#89c0d0"
	  set -g @nova-status-style-active-fg "#2e3540"
	  set -g @nova-status-style-double-bg "#2d3540"

	  set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"

	  set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
	  set -g @nova-segment-mode-colors "#78a2c1 #2e3440"

	  set -g @nova-segment-whoami "#(whoami)@#h"
	  set -g @nova-segment-whoami-colors "#78a2c1 #2e3440"

	  set -g @nova-rows 0
	  set -g @nova-segments-0-left "mode"
	  set -g @nova-segments-0-right "whoami"
      		'';
  };
}
