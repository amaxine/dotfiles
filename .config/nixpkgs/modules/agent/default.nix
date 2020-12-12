{ pkgs, config, ... }:

{
  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = 7200;
    defaultCacheTtlSsh = 7200;

    maxCacheTtl = 14400;
    maxCacheTtlSsh = 14400;

    enableSshSupport = true;
  };
}
