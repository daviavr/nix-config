{ pkgs, ...} :
{
  users.users.davi.packages = with pkgs; 
  [
    kitty 
  ]; 
}
