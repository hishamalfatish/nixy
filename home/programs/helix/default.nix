{config, pkgs, inputs, ...}:
{
programs.helix = {
  enable = true;
  package = pkgs.helix;
  settings = {
    theme = "catppuccin_macchiato";
    editor = {
      "true-color" = true;
      line-number = "absolute";
      cursorline = true;
      scrolloff = 5;

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      indent-guides = {
        render = true;
      };
    };
  };
};
xdg.configFile."helix/themes".source = "${inputs."catppuccin-helix"}/themes";
}
