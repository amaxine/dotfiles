{ pkgs, config, ... }:

{
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fish
    git
    gnupg
    htop
    powerline-go
    tmux
    unrar
    unzip
  ];

  xdg = {
    enable = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";

    userDirs = {
      enable = true;

      desktop = "${config.xdg.configHome}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Download";
      music = "${config.xdg.userDirs.documents}/Music";
      pictures = "${config.xdg.userDirs.documents}/Pictures";
      publicShare = "${config.xdg.userDirs.documents}/Public";
      templates = "${config.xdg.configHome}/Templates";
      videos = "${config.xdg.userDirs.documents}/Videos";
    };

    # Gnome tends to overwrite it anyway, so this avoids failure
    configFile."user-dirs.dirs".force = true;
  };

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
      l = "log";
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

  programs.htop = {
    enable = true;

    headerMargin = false;
    meters = {
      left = [ "LeftCPUs2" "Memory" "Swap" "Hostname" ];
      right = [ "RightCPUs2" "Tasks" "LoadAverage" "Uptime" ];
    };
  };

  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = 7200;
    defaultCacheTtlSsh = 7200;

    maxCacheTtl = 14400;
    maxCacheTtlSsh = 14400;

    enableSshSupport = true;
  };

  systemd.user.startServices = true;
}
