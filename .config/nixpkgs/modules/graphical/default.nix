{ pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    powerline-fonts
    vscodium
    slack
    firefox-wayland
    kitty
    quasselClient
    spotify
    _1password-gui
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
          [ "dash-to-dock@micxgx.gmail.com" "no-title-bar@jonaspoehler.de" "appindicatorsupport@rgcjonas.gmail.com" ];
      };

      "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
        show-battery-percentage = true;
        cursor-theme = "Yaru";
        gtk-theme = "Yaru";
        icon-theme = "Yaru";
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        animate-show-apps = false;
        apply-custom-theme = false;
        click-action = "previews";
        custom-background-color = false;
        custom-theme-customize-running-dots = true;
        custom-theme-running-dots-border-color = "#f57900";
        custom-theme-running-dots-color = "#fcaf3e";
        custom-theme-shrink = true;
        dash-max-icon-size = 32;
        dock-fixed = true;
        extend-height = true;
        running-indicator-style = "DASHES";
        show-mounts = false;
        show-trash = false;
        transparency-mode = "DYNAMIC";
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        {
          binding = "<Primary><Alt>t";
          command = "kitty";
          name = "Launch Terminal";
        };

      "org/gnome/desktop/input-sources" = {
        xkb-options = [ "caps:ctrl_modifier" ];
      };

      "org/gnome/shell" = {
        always-show-log-out = true;
      };
    };
  };
}
