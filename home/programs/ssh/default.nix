{
  programs,
  lib,
  ...
}: {
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      atlas = lib.hm.dag.entryBefore ["*"] {
        hostname = "192.168.100.100";
        user = "root";
        identitiesOnly = false;
        extraOptions = {
          PubkeyAuthentication = "no";
          PreferredAuthentications = "password,keyboard-interactive";
        };
      };
      mikrotik = lib.hm.dag.entryBefore ["*"] {
        hostname = "192.168.88.1";
        user = "admin";
        identitiesOnly = false;
        extraOptions = {
          PubkeyAuthentication = "no";
          PreferredAuthentications = "password,keyboard-interactive";
        };
      };
      "*" = {
        identitiesOnly = true;
        identityFile = ["~/.ssh/key"];
        extraOptions = {
          AddKeysToAgent = "yes";
        };
      };
      "github.com" = {
        user = "git";
        identitiesOnly = true;
        identityFile = ["~/.ssh/key"];
        extraOptions = {AddKeysToAgent = "yes";};
      };
      "gitlab.com" = {user = "git";};
      "git.homevps.io" = {user = "git";};
    };
  };
}
