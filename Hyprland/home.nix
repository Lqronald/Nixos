{ config, pkgs, ... }:

{
  home.username = "honald";
  home.homeDirectory = "/home/honald";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.bash = {
    enable = true;
    #enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      c = "clear";
      nf = "neofetch";
      pf = "pfetch";
      #matrix = "cmatrix";
      #wifi = "nmtui";
      rw = "~/dotfiles/waybar/reload.sh";
      config = "cd /run/media/ronald/LinuxData/Nixos/Hyprland/";
    };
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

  };

  home.file.".config/waybar" = {
    source = ~/dotfiles/waybar;
    recursive = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bibata-cursors
    cliphist
    dmenu
    dunst
    figlet
    gum
    hyprland-protocols
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    networkmanagerapplet
    papirus-icon-theme
    pavucontrol
    pyprland
    python311Packages.python-pipedrive
    python311Packages.psutil
    python311Packages.rich
    python311Packages.click
    pywal
    rofi-wayland
    starship
    swappy
    swaylock-effects
    swww
    waybar
    wl-clipboard
    wlogout
    xdg-desktop-portal-hyprland
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;
  gtk = {
    enable = true;
    font = {
      name = "Ubuntu";
      size = 12;
      package = pkgs.ubuntu_font_family;
    };
    theme = {
      name = "Tokyonight-Storm-BL";
      package = pkgs.tokyo-night-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
      Settings = ''
      gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
      gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;


    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ronald/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
