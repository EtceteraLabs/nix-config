{ config, pkgs, ...}:

let yrashk_com = pkgs.callPackage /home/yrashk/Projects/yrashk.com {};
in
{

  networking.firewall.allowedTCPPorts = [ 80 443 ];


  services.nginx = {
      enable = true;
      virtualHosts = {
          "yrashk.com" = {
              forceSSL = true;
              enableACME = true;
              locations."/" = {
                  root = "${yrashk_com}";
              };
          };
      };
  };

}
