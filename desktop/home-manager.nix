{ pkgs, ...}:
{
  imports = [
   <home-manager/nixos>
  ];
  home-manager.users.davi = {
    wayland.windowManager = {
      sway = {
        enable = true;
        config = rec {
          modifier = "Mod4";
	  terminal = "kitty";
        };
        config.input."type:keyboard" = {
	 xkb_layout = "br";
	};
	config.output."*" = {scale = "1";mode = "2752x1152";};
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
