{...}:
{
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "My Terminal Shortcut";
      command = "kitty";
      binding = "<Super>Return";
    };
    "org/gnome/desktop/wm/keybindings" = {
      "switch-to-workspace-left" = ["<Super>A"];
      "switch-to-workspace-right" = ["<Super>D"];
      "move-to-workspace-left" = ["<Shift><Super>A"];
      "move-to-workspace-right" = ["<Shift><Super>D"];
    };
  };
}
