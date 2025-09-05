{programs, ...}: {
  # ssh-agent
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identitiesOnly = true;
        identityFile = ["~/.ssh/key"];
        extraOptions = {
          AddKeysToAgent = "yes";
        };
      };
      "github.com" = {user = "git";};
      "gitlab.com" = {user = "git";};
      "git.homevps.io" = {user = "git";};
    };
  };
}
