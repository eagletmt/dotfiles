local wezterm = require 'wezterm'

local config = wezterm.config_builder()

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_domain = 'WSL:Arch'

  config.font = wezterm.font('Consolas')
end
if wezterm.target_triple == 'aarch64-apple-darwin' then
  config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
end

config.font_size = 13

config.front_end = 'OpenGL'
config.color_scheme = 'Wombat'
config.window_background_opacity = 0.96

config.audible_bell = 'Disabled'

config.initial_rows = 52
config.initial_cols = 220
config.enable_scroll_bar = true

config.treat_east_asian_ambiguous_width_as_wide = true
config.use_ime = false

return config
