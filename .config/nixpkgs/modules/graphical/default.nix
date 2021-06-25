{ pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    powerline-fonts
    vscode
    slack
    firefox-wayland
    quasselClient
    spotify
    _1password-gui
    aws-vault
  ];

  dconf = {
    enable = true;

    settings = {
      "org/gnome/settings-daemon/plugins/power" = {
        power-button-action = "hibernate";
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };

      "org/gnome/shell" = {
        enabled-extensions =
          [ "appindicatorsupport@rgcjonas.gmail.com" ];
      };

      "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
        show-battery-percentage = true;
        cursor-theme = "Yaru";
        gtk-theme = "Yaru";
        icon-theme = "Yaru";
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        {
          binding = "<Primary><Alt>t";
          command = "gnome-terminal";
          name = "Launch Terminal";
        };

      "org/gnome/desktop/input-sources" = {
        xkb-options = [ "caps:ctrl_modifier" ];
      };

      "org/gnome/shell" = {
        always-show-log-out = true;
      };

      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
    };
  };
}
