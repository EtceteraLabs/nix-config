{ config, pkgs, ... }:

let mgmt = pkgs.stdenv.mkDerivation {
  name = "tarsnap-mgmt";
  phases = ["wrapPhase"];
  buildInputs = [ pkgs.makeWrapper pkgs.tarsnap ];
  wrapPhase = ''
    mkdir -p $out/bin
    makeWrapper ${pkgs.tarsnap}/bin/tarsnap $out/bin/tarsnap-keyed --add-flags "--keyfile ${./tarsnap.key}"
  '';
};
in
{
#  environment.systemPackages = config.environment.systemPackages ++ [ mgmt ];
  environment.systemPackages = [ mgmt ];
  services.tarsnap = {
    enable = true;
    keyfile = builtins.toString ./tarsnap.key;
    archives = {
      mail = {
        directories = [ config.mailserver.mailDirectory config.mailserver.dkimKeyDirectory ];
        period = "*:30";
      };
      git = {
        directories = [ config.services.gitolite.dataDir ];
        period = "*:00";
      };
    };
  };
}
