-- require("format")
require("status")
-- require("keybinds")
-- require("event")

local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- keybinds
config.disable_default_key_bindings = false
-- config.keys = require("keybinds").keys
-- config.key_tables = require("keybinds").key_tables
-- config.leader = { key = ",", mods = "CTRL", timeout_milliseconds = 2000 }
--
-- colors
-- config.color_scheme = "Poimandres"
config.color_scheme = "Catppuccin Frappe"
-- config.window_background_opacity = 1

-- font
-- config.font = require("wezterm").font("JetbrainsMono Nerd Font Mono", { italic = false })
config.font = require("wezterm").font("UDEV Gothic 35NF", { italic = false })
config.font_size = 12.0
config.window_frame = {
  font = wezterm.font({ family = "JetbrainsMono Nerd Font Mono", weight = "Bold" }),
  font_size = 11.0,
}
config.front_end = "WebGpu"
-- status
config.status_update_interval = 1000

-- window decorations
if os.getenv("OSTYPE") == "linux-gnu" then
  config.window_decorations = "NONE"
else
  config.window_decorations = "RESIZE"
end
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
-- mouse binds
config.mouse_bindings = require("mousebinds").mouse_bindings

-- local SSH_AUTH_SOCK = os.getenv("SSH_AUTH_SOCK")
-- if SSH_AUTH_SOCK == string.format("%s/keyring/ssh", os.getenv("XDG_RUNTIME_DIR")) then
--   local onep_auth = string.format("%s/.1password/agent.sock", wezterm.home_dir)
--   -- Glob is being used here as an indirect way to check to see if
--   -- the socket exists or not. If it didn't, the length of the result
--   -- would be 0
--   if #wezterm.glob(onep_auth) == 1 then
--     config.default_ssh_auth_sock = onep_auth
--   end
-- end
config.enable_tab_bar = false

return config
