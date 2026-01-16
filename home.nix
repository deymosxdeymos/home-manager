{ pkgs, ... }:
{
  home.username = "deymos";
  home.homeDirectory = "/home/deymos";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  imports = [
    ./modules/nvf.nix
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  home.packages = with pkgs; [
    deno
  ];
}
