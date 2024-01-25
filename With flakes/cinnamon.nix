{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    libinput.enable = true;

  # Enable cinnamon
    displayManager.gdm.enable = true;
    desktopManager.cinnamon.enable = true;
    displayManager.defaultSession = "cinnamon";
    };
}

