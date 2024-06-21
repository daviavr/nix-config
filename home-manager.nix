{ pkgs, ...}:
{
  imports = [
   <home-manager/nixos>
  ];
  home-manager.users.davi = { pkgs, ...}: {
    targets.genericLinux.enable = true;
    programs.git = {
      enable = true;
      userName = "Davi Reis";
      userEmail = "daviavr@gmail.com";
    };
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      localVariables = {
        ZSH_TMUX_AUTOSTART=true;
      };

      shellAliases = {
        update = "sudo nixos-rebuild switch";
      };
      oh-my-zsh = {
        enable = true;
	plugins = ["git tmux"];
	theme = "robbyrussell";
      };
    };
    home.stateVersion = "24.05";
  };
}
