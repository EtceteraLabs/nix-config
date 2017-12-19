{ config, pkgs, ... }:


{
   services.gitolite = {
     enable = true;
     adminPubkey = builtins.readFile ./default_admin.pub;
     user = "git";
   };
}
