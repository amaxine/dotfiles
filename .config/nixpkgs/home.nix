{ ... }:

let 
  sysconfig = (import <nixpkgs/nixos> {}).config;
in
{
  imports = [
    ( ./hosts + ( "/" + sysconfig.networking.hostName ) )
  ];
}
