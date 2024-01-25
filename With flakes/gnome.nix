{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    libinput.enable = true;

  # Enable gnome
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.defaultSession = "gnome";
    };
}
