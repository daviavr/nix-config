{ config, pkgs, ...}:
{
  imports = [ 
    ../packages/sys-packages.nix 
    ../packages/usr-packages.nix
    ./sway/default.nix 
  ];

  networking.hostName = "nixos-desktop";

  # to enable sway
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
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
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
  };

  home-manager.users.davi.programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  home-manager.users.davi.programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
  };

  services.gvfs.enable = true; 
  users.users.davi.packages = with pkgs;
  [ 
    swaybg 
    jq 
    texlive.combined.scheme-full
    pavucontrol
    gnome.nautilus
  ];
  environment.systemPackages = with pkgs; [
    xdg-utils
    gnome-text-editor
  ];
}
