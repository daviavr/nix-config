{ pkgs, ...}:
{
  imports = [ ./home-manager.nix ../packages/sys-packages.nix ../packages/usr-packages.nix ];
  networking.hostName = "nixos-desktop";

  services.gnome.gnome-keyring.enable = true;
  # to enable sway
  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ xdg-desktop-portal-gtk ];
  };

  users.users.davi.packages = with pkgs; [ glib ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
