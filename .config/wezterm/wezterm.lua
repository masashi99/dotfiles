local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local mux = wezterm.mux

config.automatically_reload_config = true
config.color_scheme = 'tokyonight-storm'
-- config.font = wezterm.font 'HackGen Console NF'
config.font_size = 16
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10
config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false

config.window_frame = {
  active_titlebar_bg = '#2a3950'
}
config.show_new_tab_button_in_tab_bar = false 
config.show_close_tab_button_in_tabs = false
config.colors = {
  tab_bar = {
    inactive_tab_edge = 'none',
  },
}

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = '  ' .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. '  '
  local icon = tab.active_pane.is_zoomed and '🔎' or ''
  local tab_text = icon .. title 

  return {
    { Background = { Color = tab.is_active and '#ae8b2d' or '#5c6d74' } },
    { Foreground = { Color = '#FFFFFF' } },
    { Text = tab_text },
  }
end)

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.disable_default_key_bindings = true
config.keys = require('keybinds').keys
config.key_tables = require('keybinds').key_tables

return config
