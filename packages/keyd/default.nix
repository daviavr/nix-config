{ pkgs, ...}:
let keydConf = builtins.readFile ./keymaps.conf;
in
{
  systemd.services.keyd = {
    description = "key remapping daemon";
    enable = true;
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.keyd}/bin/keyd";
    };
      wantedBy = ["sysinit.target"];
      requires = ["local-fs.target"];
      after = ["local-fs.target"];
  };
  environment.etc."keyd/default.conf".text = keydConf;
}
