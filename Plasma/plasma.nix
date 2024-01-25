{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

  # Enable kde plasma
  desktopManager.plasma5.enable = true;
  };
}

