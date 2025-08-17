{
  pkgs,
  inputs,
  config,
  service,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "/home/hisham/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets."weather.json" = {
      mode = "0660";
       };
   };

   home.file.".config/nixos/.sops.yaml".text = ''
  keys:
    - &primary age126jusyu9m94ny2mf690k2zzp5nnr3jvl7yd5l66k4uc3gaufsg3qa6rl74
  creation_rules:
    - path_regex: hosts/tower/secrets/secrets\.(yaml|json)$
      key_groups:
        - age:
          - *primary
  '';

  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  home.packages = with pkgs; [sops age];

  wayland.windowManager.hyprland.settings.exec-once = ["systemctl --user start sops-nix"];

}
