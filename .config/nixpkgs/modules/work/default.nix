{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible
    yubikey-manager
    yubioath-desktop
    tflint
    awscli
    ssm-session-manager-plugin
    terraform_0_12
    sops
    zoom-us
    google-chrome
    terraform-providers.sops
  ];
}
