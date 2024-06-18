{ pkgs, ...}:
{
  imports = [ ./home-manager.nix ../packages/sys-packages.nix ../packages/usr-packages.nix ];
  networking.hostName = "nixos-desktop";

  # to enable sway
  security.polkit.enable = true;

  users.users.davi.packages = with pkgs; [ glib ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
