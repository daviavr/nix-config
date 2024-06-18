{pkgs, ...}: {
imports  = [ 
  ./keyd/default.nix 
];
environment.systemPackages = with pkgs; [
    neovim
    git
    zsh
    keyd
    kitty
];}
