{pkgs, ...}: {
  home.packages = with pkgs; [
    lazygit
    tig
  ];
  programs.git = {
    enable = true;
    userName = "knakto";
    userEmail = "kasichonooo@gmail.com";
  };
}
