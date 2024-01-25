{ config, pkgs, ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # This variable fixes electron apps in wayland
  environment.sessionVariables.WLR_MO_HARDWARE_CURSOR = "1";

  environment.systemPackages = with pkgs; [

  ];

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;

  };
}

