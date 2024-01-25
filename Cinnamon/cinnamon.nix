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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ronald = {
    isNormalUser = true;
    description = "ronald";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
	  cinnamon.cinnamon-common
	  cinnamon.cinnamon-control-center
	  cinnamon.cinnamon-settings-daemon
	  cinnamon.cinnamon-session
	  cinnamon.cinnamon-menus
	  cinnamon.cinnamon-translations
	  cinnamon.cinnamon-screensaver
	  cinnamon.cinnamon-desktop
      guake
    ];
  };
}

