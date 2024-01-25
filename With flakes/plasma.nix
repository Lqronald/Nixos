{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    libinput.enable = true;

  # Enable kde plasma
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    displayManager.defaultSession = "plasma";
    };
}

