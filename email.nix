{ config, pkgs, ... }:
{
  imports = [
    (builtins.fetchTarball "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/v2.1.4/nixos-mailserver-v2.1.4.tar.gz")
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

  systemd.slices.rspamd = {
    description = "rspamd can sometimes grow uncontrollably";
    before = [ "slices.target" ];
    sliceConfig = {
      MemoryHigh = "512M";
      MemoryMax = "700M";
    };
  };
  systemd.services.rspamd = {
    serviceConfig = {
      Slice = "rspamd.slice";
    };
  };
}
