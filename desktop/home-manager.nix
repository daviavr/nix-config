{ pkgs, lib, ...}:
let 
  mod = "Mod4";
  cursorTheme = "Bibata-Modern-Classic";
  cursorSize = 20;
  cursorPackage = pkgs.bibata-cursors;
  drun = "pkill tofi-drun || tofi-drun | xargs swaymsg exec --";
in
{
  imports = [
   <home-manager/nixos>
  ];
  home-manager.users.davi = {
    home.pointerCursor = {
      name = cursorTheme;
      package = cursorPackage;
      size = cursorSize;
      x11 = {
        enable = true;
	defaultCursor = cursorTheme;
      };
      gtk.enable = true;
    };

    home.file = { 
      ".config/tofi/config" = {
        text = builtins.readFile ./tofi.settings;
      };
    };

    wayland.windowManager = {
      sway = {
        enable = true;
        config = rec {
          modifier = "${mod}";
	        terminal = "kitty";
        };
        config.input."type:keyboard" = {
          xkb_layout = "br";
        };
        config.output."*" = {
          scale = "1.25";
          mode = "3440x1440@144Hz";
        };
        config.defaultWorkspace = "workspace number 1";
        config.keybindings = lib.mkOptionDefault{
          "${mod}+u" = "workspace number 1";
          "${mod}+i" = "workspace number 2";
          "${mod}+o" = "workspace number 3";
          "${mod}+m" = "workspace number 4";
          "${mod}+Shift+u" = "move container to workspace number 1";
          "${mod}+Shift+i" = "move container to workspace number 2";
          "${mod}+Shift+o" = "move container to workspace number 3";
          "${mod}+Shift+m" = "move container to workspace number 4";
          "${mod}+p" = "scratchpad show";
          "${mod}+Shift+p"= "move scratchpad";
          "${mod}+Tab" = "workspace next";
          "${mod}+Escape" = "workspace prev";
          "${mod}+y" = "fullscreen toggle";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+e" = "layout toggle split";
          "${mod}+q" = "kill";
          "${mod}+d" = "exec --no-startup-id ${drun}";
        };
        config.seat."*" = {
          xcursor_theme = "${cursorTheme} ${builtins.toString cursorSize}";
        };
      };
    };

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
    gtk = {
      enable = true;
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
      gtk4 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
