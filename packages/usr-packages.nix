{ pkgs, ...} :
{
  users.users.davi.packages = with pkgs; 
  [
    kitty 
    gnome.gnome-disk-utility
    wl-clipboard
    gnome.seahorse
  ]; 
}
