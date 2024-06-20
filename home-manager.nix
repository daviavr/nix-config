{ pkgs, ...}:
{
  imports = [
   <home-manager/nixos>
  ];
  home-manager.users.davi = { pkgs, ...}: {
    targets.genericLinux.enable = true;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      shellAliases = {
        update = "sudo nixos-rebuild switch";
      };
      oh-my-zsh = {
        enable = true;
	plugins = ["git"];
	theme = "robbyrussell";
      };
    };
    home.stateVersion = "24.05";
  };
}
