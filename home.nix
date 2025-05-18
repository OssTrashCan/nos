{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "tpadterry";
  home.homeDirectory = "/home/tpadterry";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Enable Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    
    settings = {
      # Monitor configuration
      monitor = [
        # Adjust this to match your monitor setup
        ",preferred,auto,1"
      ];
      
      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      
      # Decoration settings
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      
      # Animation settings
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      
      # Input settings
      input = {
        kb_layout = "au";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };
      
      # Dwindle layout settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      
      # Master layout settings
      master = {
        new_is_master = true;
      };
      
      # Gestures
      gestures = {
        workspace_swipe = true;
      };
      
      # Window rules
      windowrule = [
        "float, ^(pavucontrol)$"
        "float, ^(nm-connection-editor)$"
        "float, ^(galculator)$"
      ];
      
      # Key bindings
      "$mod" = "SUPER";
      bind = [
        # Basic bindings
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, nautilus"
        "$mod, V, togglefloating,"
        "$mod, R, exec, wofi --show drun"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
        
        # Move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        
        # Switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move active window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # Scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        
        # Screenshots
        ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "SHIFT, Print, exec, grim - | swappy -f -"
      ];
      
      # Move/resize windows with mod + LMB/RMB and dragging
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      
      # Autostart applications
      exec-once = [
        "waybar"
        "mako"
        "nm-applet --indicator"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
    };
  };
  
  # Configure Waybar
  programs.waybar = {
    enable = true;
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrains Mono", "Font Awesome 6 Free";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(21, 18, 27, 0.9);
        color: #cdd6f4;
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 10px;
        border-width: 2px;
        border-style: solid;
        border-color: #11111b;
      }

      #workspaces button {
        padding: 5px;
        color: #313244;
        margin-right: 5px;
      }

      #workspaces button.active {
        color: #a6adc8;
      }

      #workspaces button.focused {
        color: #a6adc8;
        background: #eba0ac;
        border-radius: 10px;
      }

      #workspaces button.urgent {
        color: #11111b;
        background: #a6e3a1;
        border-radius: 10px;
      }

      #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
        border-radius: 10px;
      }

      #custom-language,
      #custom-updates,
      #custom-caffeine,
      #custom-weather,
      #window,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #workspaces,
      #tray,
      #backlight {
        background: #1e1e2e;
        padding: 0px 10px;
        margin: 3px 0px;
        margin-top: 10px;
        border: 1px solid #181825;
      }

      #tray {
        border-radius: 10px;
        margin-right: 10px;
      }

      #workspaces {
        background: #1e1e2e;
        border-radius: 10px;
        margin-left: 10px;
        padding-right: 0px;
        padding-left: 5px;
      }

      #custom-caffeine {
        color: #89dceb;
        border-radius: 10px 0px 0px 10px;
        border-right: 0px;
        margin-left: 10px;
      }

      #custom-language {
        color: #f38ba8;
        border-left: 0px;
        border-right: 0px;
      }

      #custom-updates {
        color: #f5c2e7;
        border-radius: 10px 0px 0px 10px;
        border-left: 0px;
        border-right: 0px;
      }

      #window {
        border-radius: 10px;
        margin-left: 60px;
        margin-right: 60px;
      }

      #clock {
        color: #fab387;
        border-radius: 10px 0px 0px 10px;
        margin-left: 5px;
        border-right: 0px;
      }

      #network {
        color: #f9e2af;
        border-left: 0px;
        border-right: 0px;
      }

      #pulseaudio {
        color: #89b4fa;
        border-left: 0px;
        border-right: 0px;
      }

      #pulseaudio.microphone {
        color: #cba6f7;
        border-left: 0px;
        border-right: 0px;
      }

      #battery {
        color: #a6e3a1;
        border-radius: 0 10px 10px 0;
        margin-right: 10px;
        border-left: 0px;
      }
    '';
    
    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "pulseaudio" "network" "clock" "tray" ];
      
      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
          "10" = "10";
        };
      };
      
      "clock" = {
        format = "{:%H:%M}";
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      
      "network" = {
        format-wifi = "  {essid}";
        format-ethernet = "󰈀 Connected";
        format-disconnected = "󰈂 Disconnected";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      };
      
      "pulseaudio" = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 Muted";
        format-icons = {
          default = [ "󰕿" "󰖀" "󰕾" ];
        };
        on-click = "pavucontrol";
      };
      
      "tray" = {
        icon-size = 18;
        spacing = 10;
      };
    }];
  };
  
  # Configure Wofi application launcher
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
    style = ''
      * {
        font-family: "JetBrains Mono";
        font-size: 14px;
      }

      window {
        margin: 0px;
        border: 2px solid #cba6f7;
        border-radius: 15px;
        background-color: #1e1e2e;
      }

      #input {
        margin: 5px;
        padding: 10px;
        border: none;
        color: #cdd6f4;
        background-color: #313244;
        border-radius: 10px;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: transparent;
        border-radius: 10px;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: transparent;
        border-radius: 10px;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #cdd6f4;
      }

      #entry:selected {
        background-color: #313244;
        border-radius: 10px;
      }
    '';
  };
  
  # Configure Mako notification daemon
  services.mako = {
    enable = true;
    font = "JetBrains Mono 10";
    width = 300;
    height = 100;
    borderSize = 2;
    borderRadius = 10;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    defaultTimeout = 5000;
  };
  
  # Configure Kitty terminal
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 11;
    };
    settings = {
      background_opacity = "0.95";
      window_padding_width = 8;
      confirm_os_window_close = 0;
      background = "#1E1E2E";
      foreground = "#CDD6F4";
      cursor = "#F5E0DC";
      selection_background = "#F5E0DC";
      selection_foreground = "#1E1E2E";
      active_tab_background = "#CBA6F7";
      active_tab_foreground = "#1E1E2E";
      inactive_tab_background = "#181825";
      inactive_tab_foreground = "#CDD6F4";
      tab_bar_margin_width = "1.0";
      tab_bar_style = "powerline";
    };
  };
  
  # Enable GTK theme for better Wayland integration
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
  };
  
  # Install additional packages for the user
  home.packages = with pkgs; [
    # Fonts
    jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-emoji
    
    # Theming
    catppuccin-gtk
    papirus-icon-theme
    
    # Utilities
    swww            # Wallpaper daemon
    cliphist        # Clipboard manager
    wlogout         # Logout menu
    
    # Development
    vscode
    
    # Media
    mpv
    imv             # Image viewer
  ];
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "24.11";
}