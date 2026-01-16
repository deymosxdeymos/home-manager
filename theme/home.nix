{ pkgs, ... }: {
  home.file.".icons/default/index.theme".text = ''
    [Icon Theme]
    Inherits=breeze_cursors
  '';

  xdg.configFile = let
    qtctConf = kdecolors: ''
      [Appearance]
      ${if kdecolors then ''
        color_scheme_path=${pkgs.breeze}/share/color-schemes/BreezeDark.colors
      '' else ''
        color_scheme_path=${./colors-qt5ct.conf}
      ''}
      custom_palette=true
      icon_theme=breeze-dark
      standard_dialogs=xdgdesktopportal
      style=Breeze

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=2
      double_click_interval=400
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      toolbutton_style=2
      underline_shortcut=1
      wheel_scroll_lines=3

      [Troubleshooting]
      force_raster_widgets=0
    '';
  in {
    "kdeglobals".source = "${pkgs.breeze}/share/color-schemes/BreezeDark.colors";
    "qt5ct/qt5ct.conf".text = qtctConf false;
    "qt6ct/qt6ct.conf".text = qtctConf true;
  };

  home.packages = with pkgs; [
    breeze
    breeze-gtk
    breeze-icons
  ];

  gtk = {
    enable = true;
    theme = {
      package = breeze-gtk;
      name = "Breeze-Dark";
    };
    iconTheme = {
      package = breeze-icons;
      name = "breeze-dark";
    };
    cursorTheme = {
      package = breeze-gtk;
      name = "breeze_cursors";
    };

    gtk3.extraConfig.gtk-xft-rgba = "rgb";
    gtk4.extraConfig.gtk-xft-rgba = "rgb";
  };
}
