{ config, pkgs, lib, ...}:
let 
  mod = "Mod4";
  cursorTheme = "Bibata-Modern-Classic";
  cursorSize = 20;
  cursorPackage = pkgs.bibata-cursors;
  drun = "pkill wofi || wofi --show drun";
  currPath = ./.;
in
{
  imports = [
   <home-manager/nixos>
  ];
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
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

    programs.wofi = {
    enable = true;
    style = ''window {
margin: 0px;
border: 1px solid #928374;
background-color: #282828;
}

#input {
margin: 5px;
border: none;
color: #ebdbb2;
background-color: #1d2021;
}

#inner-box {
margin: 5px;
border: none;
background-color: #282828;
}

#outer-box {
margin: 5px;
border: none;
background-color: #282828;
}

#scroll {
margin: 0px;
border: none;
}

#text {
margin: 5px;
border: none;
color: #ebdbb2;
}

#entry:selected {
background-color: #1d2021;
}
'';};

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
	config.startup = [
	  { command = "systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service"; }  
	];
	config.window.commands = [
	  { criteria = { app_id = "dropin"; }; command = "move scratchpad"; }
	];
        config.keybindings = lib.mkOptionDefault{
          "${mod}+u" = "workspace number 1";
          "${mod}+i" = "workspace number 2";
          "${mod}+o" = "workspace number 3";
          "${mod}+p" = "workspace number 4";
          "${mod}+Shift+u" = "move container to workspace number 1";
          "${mod}+Shift+i" = "move container to workspace number 2";
          "${mod}+Shift+o" = "move container to workspace number 3";
          "${mod}+Shift+p" = "move container to workspace number 4";
          "${mod}+m" = "exec ${currPath}/floating-terminal.sh";
          "${mod}+Shift+n" = "exec ${currPath}/scratchpad.sh add";
          "${mod}+n" = "exec ${currPath}/scratchpad.sh";
          "${mod}+Tab" = "workspace next";
          "${mod}+Escape" = "workspace prev";
          "${mod}+y" = "fullscreen toggle";
          "${mod}+Shift+space" = "exec ${currPath}/floating-toggle.sh";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+e" = "layout toggle split";
          "${mod}+q" = "exec ${currPath}/kill.sh";
          "${mod}+d" = "exec ${drun}";
        };
        config.seat."*" = {
          xcursor_theme = "${cursorTheme} ${builtins.toString cursorSize}";
        };
      };
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

