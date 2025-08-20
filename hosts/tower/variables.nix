{
  config,
  lib,
  ...
}: {
  imports = [
    # Choose your theme here:
    ../../themes/catppuccin.nix
  ];

  config.var = {
    hostname = "tower";
    username = "hisham";
    configDirectory =
      "/home/"
      + config.var.username
      + "/.config/nixos"; # The path of the nixos configuration directory

    keyboardLayout = "de";

    location = "51.3397,12.3731"; #Leipzig
    timeZone = "Europe/Berlin";
    defaultLocale = "de_DE.UTF-8";
    extraLocale = "de_DE.UTF-8";

    git = {
      username = "hishamalfatish";
      email = "hisham.alfatish@gmail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
