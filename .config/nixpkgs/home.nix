{ pkgs, config, ... }:

let 
  sysconfig = (import <nixpkgs/nixos> {}).config;
in
let
  fqdn = "${sysconfig.networking.hostName}";
in
{
  imports = [
    ( ./hosts + ( "/" + sysconfig.networking.hostName ) )
  ];
}
