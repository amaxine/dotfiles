{ pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    powerline-fonts
    vscode
    slack
    firefox-wayland
    quasselClient
    aws-vault

    awscli2
    ssm-session-manager-plugin
    terraform
    tflint
    jq
    gnumake
    packer
    golangci-lint
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
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/1password0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/1password1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/1password2/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        {
          binding = "<Primary><Alt>t";
          command = "gnome-terminal";
          name = "Launch Terminal";
        };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/1password0" =
        {
          binding = "<Primary><Shift>l";
          command = "1password --lock";
          name = "Lock 1Password";
        };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/1password1" =
        {
          binding = "<Primary><Shift>space";
          command = "1password --quick-access";
          name = "1Password Quick Access";
        };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/1password2" =
        {
          binding = "";
          command = "1password --toggle";
          name = "Open 1Password";
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
