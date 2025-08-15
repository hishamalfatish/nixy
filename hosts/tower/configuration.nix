{config, pkgs, ...}: {
  imports = [
    # Mostly system related configuration
    ../../nixos/nvidia.nix # CHANGEME: Remove this line if you don't have an Nvidia GPU
    ../../nixos/audio.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/sddm.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/tailscale.nix
    ../../nixos/hyprland.nix

    ../../nixos/omen.nix # For my laptop only

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;
  # loader for dynamic library
  programs.nix-ld.enable = true;

  # sudo
  security.sudo.wheelNeedsPassword = true;
  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults timestamp_timeout=5
    '';
  };

  environment.systemPackages = with pkgs; [
    (pkgs.python313.withPackages (ps: with ps; [
      requests
      selenium
      pandas
    ]))
    geckodriver
  ];

  # Don't touch this
  system.stateVersion = "24.05";
}
