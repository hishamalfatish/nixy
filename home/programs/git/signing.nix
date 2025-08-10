# This file is used to sign git commits using an SSH key.
{
  # Obviously, change this to your own SSH key.
  home.file.".ssh/allowed_signers".text = "* ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP1G6l8QHJdM5oUEPFa7NOmdMtHKWydxDCn2wysVuV2t hisham@tower";

  programs.git.extraConfig = {
    commit.gpgsign = true;
    gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    gpg.format = "ssh";
    user.signingkey = "~/.ssh/key.pub";
  };
}
