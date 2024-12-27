# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # for efi only

  networking.hostName = "ttnjja-x240"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  time.timeZone = "Asia/Tokyo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    inputMethod = {
      enabled = "fcitx5"; # Keep this as string "fcitx5", not using type/enable
      fcitx5.addons = [ pkgs.fcitx5-mozc ];
    };
  };

  # Console config
  console = {
    font = "${(pkgs.callPackage ./unifont256-psf1.nix {})}/share/consolefonts/unifont.psf.gz";
    useXkbConfig = true;
  };

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      terminus_font
      terminus_font_ttf
    ];
    fontconfig.defaultFonts = {
      # Added Noto fonts as primary for better CJK support
      monospace = [ "Noto Sans Mono CJK JP" "DejaVu Sans Mono" ]; # CJK priority
      sansSerif = [ "Noto Sans CJK JP" ];
      serif = [ "Noto Serif CJK JP" ];
    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb.layout = "jp";
    # xserver.xkb.options = "eurosign:e,caps:escape";

    displayManager = {
      lightdm = {
        enable = true;
        greeters.gtk.enable = true;
      };
      defaultSession = "none+xmonad";
    };

    windowManager.xmonad = {
      enable = true;
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.enzo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "input" ]; # Enable 'sudo' for the user.
    packages = with pkgs; [
      tree
      firefox
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    gtk3 # Required for lightdm greeter
    nix-index
    vim
    wget
    xorg.xauth
    xorg.xinit
    rsync
  ];

  #Typing
  # Vi mode for login shells
  environment.shellInit = ''
    set -o vi
    bind -m vi-insert '"\C-l": clear-screen'
  '';

  # Vi mode for non-login shells
  environment.etc."bash.bashrc".text = ''
    set -o vi
    bind -m vi-insert '"\C-l": clear-screen'
  '';

  # programs.nix-index = {
  # enable = true;
  # enableBashIntegration = true;
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
