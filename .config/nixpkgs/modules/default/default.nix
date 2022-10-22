{ pkgs, config, ... }:

{
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fish
    fishPlugins.foreign-env
    gcc
    git
    gitAndTools.gh
    gnupg
    go
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
      download = "${config.home.homeDirectory}/Downloads";
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
    interactiveShellInit = ''
      function fish_prompt
          if test -n "$IN_NIX_SHELL"
              echo -n "nix> "
          end
          eval ${pkgs.powerline-go}/bin/powerline-go -error $status -shell bare -colorize-hostname -modules host,ssh,cwd,perms,jobs,exit -cwd-mode plain
      end
      function fish_right_prompt
          eval ${pkgs.powerline-go}/bin/powerline-go -shell bare -mode flat -modules vgo,venv,git,hg
      end
      set EDITOR vim
      set fish_greeting
          '';
    shellAliases = {
      ".." = "cd ..";
      home =
        "git --work-tree=${config.home.homeDirectory} --git-dir=${config.xdg.configHome}/home.git";
      l = "ls -lAh";
      nix-shell = "nix-shell --run fish";
    };
  };

  programs.git = {
    enable = true;
    userName = "Maxine Aubrey";
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
      rma = "!sh -c 'git rebase $(git rev-parse --abbrev-ref origin/HEAD | cut -d/ -f2- || echo -n main)'";
      s = "status";
      sw = "switch";
      sc = "switch -c";
      sm = "!sh -c 'git switch $(git rev-parse --abbrev-ref origin/HEAD | cut -d/ -f2- || echo -n main)'";
      undo = "reset --soft HEAD^";
    };
    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };

  programs.htop = {
    enable = true;

    settings = {
      header_margin = false;
      left_meters = [ "LeftCPUs2" "Memory" "Swap" "Hostname" ];
      right_meters = [ "RightCPUs2" "Tasks" "LoadAverage" "Uptime" ];
    };
  };

  systemd.user.startServices = true;
}
