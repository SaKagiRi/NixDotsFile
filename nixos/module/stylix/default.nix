{
  pkgs,
  self,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      gtk.enable = true;
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    polarity = "dark";
  };
}
