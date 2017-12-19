{ config, pkgs, ... }:
{
  imports = [
    (builtins.fetchTarball "https://github.com/r-raymond/nixos-mailserver/archive/v2.0.3.tar.gz")
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.etceteralabs.com";
    domains = [ "yrashk.com" "rashkovskii.com" ];
    loginAccounts = {
        "me@yrashk.com" = {
            hashedPassword = config.users.extraUsers.yrashk.hashedPassword;
            aliases = [
               "yurii@rashkovskii.com"
            ];
            catchAll = ["yrashk.com"];
        };
    };

    certificateScheme = 3;
    enableImap = true;
    enableImapSsl = true;
  };
}