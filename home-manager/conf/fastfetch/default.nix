{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "~/.face";
        height = 16;
        padding = {
          left = 2;
          right = 2;
          top = 2;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "blue";
        separator = "  ";
      };
      modules = [
        "break"
        {
          "type" = "os";
          "key" = " DISTRO";
          "keyColor" = "yellow";
        }
        {
          "type" = "kernel";
          "key" = "│ ├";
          "keyColor" = "yellow";
        }
        {
          "type" = "packages";
          "key" = "│ ├󰏖";
          "keyColor" = "yellow";
        }
        {
          "type" = "shell";
          "key" = "│ └";
          "keyColor" = "yellow";
        }
        {
          "type" = "wm";
          "key" = " DE/WM";
          "keyColor" = "blue";
        }
        {
          "type" = "wmtheme";
          "key" = "│ ├󰉼";
          "keyColor" = "blue";
        }
        #{
        #	"type" = "icons";
        #		"key" = "│ ├󰀻";
        #	"keyColor" = "blue";
        #}
        #{
        #	"type" = "cursor";
        #	"key" = "│ ├";
        #	"keyColor" = "blue";
        #}
        {
          "type" = "terminalfont";
          "key" = "│ ├";
          "keyColor" = "blue";
        }
        {
          "type" = "terminal";
          "key" = "│ └";
          "keyColor" = "blue";
        }
        {
          "type" = "host";
          "key" = "󰌢 SYSTEM";
          "keyColor" = "green";
        }
        {
          "type" = "cpu";
          "key" = "│ ├󰻠";
          "keyColor" = "green";
        }
        {
          "type" = "gpu";
          "key" = "│ ├󰻑";
          "format" = "{2}";
          "keyColor" = "green";
        }
        {
          "type" = "display";
          "key" = "│ ├󰍹";
          "keyColor" = "green";
          "compactType" = "original-with-refresh-rate";
        }
        {
          "type" = "memory";
          "key" = "│ ├󰾆";
          "keyColor" = "green";
        }
        {
          "type" = "swap";
          "key" = "│ ├󰓡";
          "keyColor" = "green";
        }
        {
          "type" = "uptime";
          "key" = "│ ├󰅐";
          "keyColor" = "green";
        }
        {
          "type" = "display";
          "key" = "│ └󰍹";
          "keyColor" = "green";
        }
        {
          "type" = "sound";
          "key" = " AUDIO";
          "format" = "{2}";
          "keyColor" = "magenta";
        }
        {
          "type" = "player";
          "key" = "│ ├󰥠";
          "keyColor" = "magenta";
        }
        {
          "type" = "media";
          "key" = "│ └󰝚";
          "keyColor" = "magenta";
        }
        "break"
      ];
    };
  };
}
