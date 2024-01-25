# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hyprland.nix
      ./plasma.nix
      #./gnome.nix
      #./cinnamon.nix
      <home-manager/nixos>
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernel.sysctl."kernel.sysrq" = 1;

  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.kernelParams = [ "quiet" "udev.log_level=0" ];


  networking.hostName = "nixpc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    #libinput.enable = true;
    dpi = 192;
    # Enable SDDM
    displayManager.sddm = {
       enable = true;
       enableHidpi = true;
       #wayland.enable = true;
       theme = "breeze";
    };
    displayManager.defaultSession = "plasma";
  };

  # For swaylock to unlock use :
  security.pam.services.swaylock = {};


  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_BE.UTF-8";
    LC_IDENTIFICATION = "nl_BE.UTF-8";
    LC_MEASUREMENT = "nl_BE.UTF-8";
    LC_MONETARY = "nl_BE.UTF-8";
    LC_NAME = "nl_BE.UTF-8";
    LC_NUMERIC = "nl_BE.UTF-8";
    LC_PAPER = "nl_BE.UTF-8";
    LC_TELEPHONE = "nl_BE.UTF-8";
    LC_TIME = "nl_BE.UTF-8";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };


 # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    terminus_font
    fira
    fira-code
    fira-code-nerdfont
  ];


    # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "steam"
      "steam-original"
      "steam-run"
    ];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;
    # Power management is required to get nvidia GPUs to behave on
    # suspend, due to firmware bugs. Aren't nvidia great?
    powerManagement.enable = true;
    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = true;
    # Enable the nvidia settings menu
    nvidiaSettings = true;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.production;
   #package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


  # Configure keymap in X11
  services.xserver = {
    layout = "be";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "be-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ronald = {
    isNormalUser = true;
    description = "ronald";
    extraGroups = [ "networkmanager" "wheel" "media" ];
    packages = with pkgs; [

    ];
  };

  users.users.honald = {
    isNormalUser = true;
    description = "honald";
    extraGroups = [ "networkmanager" "wheel" "media" ];
    packages = with pkgs; [

    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flatpak
  services.flatpak.enable = true;


  # Aliases
  environment.shellAliases = {
    "rebuild" = "sudo nixos-rebuild switch";
    };

  environment.shellAliases = {
    "rehome" = "home-manager switch";
    };

  environment.shellAliases = {
    "garbage" = "sudo nix-collect-garbage -d";
    };

  environment.shellAliases = {
     "chanup" = "sudo nix-channel --update";
    };

  environment.shellAliases = {
    "nixup" = "sudo nixos-rebuild --upgrade";
    };

  environment.shellAliases = {
    "ls" = "eza -a --icons --group-directories-first";
    };

   environment.shellAliases = {
    "ll" = "eza -al --icons --group-directories-first";
   };

   environment.shellAliases = {
    "lt" = "eza -a --tree --level=1 --icons --group-directories-first";
   };

  environment.shellAliases = {
    "cd.." = "cd ..";
    };

  environment.shellAliases = {
    "shutdown" = "systemctl poweroff";
  };

  environment.shellAliases = {
    "dot" = "cd ~/dotfiles";
  };

  # Define disks
  fileSystems."/run/media/ronald/Backup" =
    { device = "/dev/disk/by-label/Backup";
      #fsType = "nfs";
    };

  fileSystems."/run/media/ronald/Movies" =
    { device = "/dev/disk/by-label/Movies";
      #fsType = "nfs";
  };

  fileSystems."/run/media/ronald/Series" =
    { device = "/dev/disk/by-label/Series";
      #fsType = "nfs";
    };

  fileSystems."/mnt/LinuxData" =
    { device = "/dev/disk/by-partlabel/LinuxData";
      #fsType = "nfs";
    };

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    btop
    cava
    cpufetch
    eza
    gnome.gnome-disk-utility
    dolphin
    firefox
    flameshot
    gimp
    git
    gnugrep
    gparted
    htop
    ipfetch
    killall
    kitty
    libreoffice
    lutris
    meld
    micro
    mlocate
    neofetch
    nfs-utils
    ntfs3g
    okular
    os-prober
    pfetch
    protonup-qt
    protontricks
    python3
    qbittorrent
    libsForQt5.qt5ct
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtgraphicaleffects
    sddm-chili-theme
    spotify
    starship
    unzip
    vlc
    wineWowPackages.stable
    wineWowPackages.staging
    winetricks
    vim
    wget
    xdg-utils
    xdg-desktop-portal
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  services.dbus.packages = with pkgs; [
    xfce.xfconf
  ];


  xdg.portal = {
    enable = true;
  };

  # When VM's are needed
  #virtualisation.libvirtd.enable = true;
  #programs.dconf.enable = true;


  environment.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "2";
    #QT_SCREEN_SCALE_FACTORS= "1";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  # Optimize storage and automatic scheduled GC running
  # If you want to run GC manually, use commands:
  # `nix-store --optimize` for finding and eliminating redundant copies of identical store paths
  # `nix-store --gc` for optimizing the nix store and removing unreferenced and obsolete store paths
  # `nix-collect-garbage -d` for deleting old generations of user profiles
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  #nix.gc = {
  #  automatic = true;
  #  dates = "weekly";
  #  options = "--delete-older-than 7d";
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
