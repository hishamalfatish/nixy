{
  pkgs,
  config,
  programs,
  services,
  inputs,
  ...
}: {
  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../home/programs/kitty
    ../../home/programs/nvf
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/git/signing.nix
    ../../home/programs/spicetify
    ../../home/programs/thunar
    ../../home/programs/lazygit
    ../../home/programs/zen
    ../../home/programs/tailscale
    ../../home/programs/helix

    # Scripts
    ../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/hypridle
    ../../home/system/hyprlock
    ../../home/system/hyprpanel
    ../../home/system/hyprpaper
    ../../home/system/wofi
    ../../home/system/zathura
    ../../home/system/mime
    ../../home/system/udiskie
    ../../home/system/clipman
    ./secrets

  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      bitwarden # Password manager
      vlc # Video player
      blanket # White-noise app
      curtail # Compress images
      steam
      
      # Dev
      go
      bun
      nodejs
      jq
      just
      pnpm
      air
      duckdb

      # Utils
      zip
      unzip
      optipng
      jpegoptim
      pfetch
      btop
      fastfetch
      vscode
      logiops

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix
   
   ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".face.icon" = {source = ./gengar.png;};

    # Don't touch this
    stateVersion = "24.05";
  };

programs.home-manager.enable = true;

# ssh-agent
services.ssh-agent.enable = true;

programs.ssh = {
  enable = true;
  matchBlocks = {
    "*" = {
      identitiesOnly = true;
      identityFile = [ "~/.ssh/key" ];
      extraOptions = {
         addKeysToAgent = "yes";
      };
    };
    "github.com" = { user = "git"; };
    "gitlab.com" = { user = "git"; };
    "git.homevps.io" = { user = "git"; };
    };
  };
programs.keychain = {
  enable = true;
  keys = [ "key" ];
  enableZshIntegration = true;
};
# stylix helix theme
stylix.targets.helix.enable = false;
}
