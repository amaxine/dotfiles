{ pkgs, config, ... }:

{
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fish
    git
    gnupg
    nixfmt
    powerline-go
    unrar
    unzip
  ];

  programs.fish = {
    enable = true;
    promptInit = ''
      function fish_prompt
          eval ${pkgs.powerline-go}/bin/powerline-go -error $status -shell bare -colorize-hostname -modules host,ssh,cwd,perms,jobs,exit -cwd-mode plain
      end
      function fish_right_prompt
          eval ${pkgs.powerline-go}/bin/powerline-go -shell bare -mode flat -modules vgo,venv,git,hg
      end
      set EDITOR vim
          '';
    shellAliases = {
      ".." = "cd ..";
      home =
        "git --work-tree=${config.home.homeDirectory} --git-dir=${config.xdg.configHome}/home.git";
      l = "ls -lAh";
    };
  };

  programs.git = {
    enable = true;
    userName = "Maxine E. Aubrey";
    userEmail = "maxeaubrey@gmail.com";
    signing = {
      key = "1F6CE814B764EC432A786C0DF6FE033DFCB899F7";
      signByDefault = true;
    };
    aliases = {
      a = "add";
      ca = "commit --amend";
      co = "checkout";
      d = "diff";
      fixup = "commit --amend --no-edit";
      lb =
        "!sh -c 'git log -$(git rev-list --count HEAD ^\${1:-master}) --topo-order --graph --date=relative --pretty=format:%Cgreen%h%Creset\\\\ %s%Cred%d%Creset\\\\ %C\\\\(yellow\\\\ bold\\\\)\\\\(%an\\\\)%Creset' $@";
      rc = "rebase --continue";
      rv = "remote -v";
      rma = "rebase master";
      s = "status";
      sw = "switch";
      undo = "reset --soft HEAD^";
    };
  };

  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = 1800;
    defaultCacheTtlSsh = 1800;

    maxCacheTtl = 14400;
    maxCacheTtlSsh = 14400;

    enableSshSupport = true;
  };

  systemd.user.startServices = true;
}