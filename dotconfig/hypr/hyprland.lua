local terminal  = "foot"
local menu      = "rofi -show drun -show-icons"
local grim      = os.getenv("HOME") .. "/dotfiles/shscript/grim/grim-select.sh"
local githubKey = os.getenv("HOME") .. "/githubKey.sh"
local hyprzoom  = os.getenv("HOME") .. "/go/bin/hypr-zoom -easing=InOutExpo -duration=100 -steps=30 -target=3"

-- ydotool helpers
local ydotoolxl = "ydotool mousemove -x -30 -y 0"
local ydotoolxr = "ydotool mousemove -x 30 -y 0"
local ydotoolyu = "ydotool mousemove -x 0 -y 30"
local ydotoolyd = "ydotool mousemove -x 0 -y -30"
local ydotoolcl = "ydotool click 0xC0"
local ydotoolcr = "ydotool click 0xC1"

local mainMod   = "SUPER"

--#############
--# EXEC ONCE #
--#############
hl.exec_once("waybar")
hl.exec_once("swaync")
hl.exec_once("hyprpaper")
hl.exec_once("fcitx5")
hl.exec_once("nm-applet")
hl.exec_once("systemctl --user start hyprpolkitagent")

--################
--### MONITORS ###
--################
hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@180.00Hz",
  position = "1920x0",
  scale = 1
})
hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@144.00Hz",
  position = "0x0",
  scale = 1
})

--#############################
--### ENVIRONMENT VARIABLES ###
--#############################
-- (CHANGED) `env = KEY,VAL` -> hl.env("KEY", "VAL")
-- NOTE: if you start Hyprland via uwsm, the wiki recommends putting these
-- inside ~/.config/uwsm/env (toolkit/cursor/nvidia) and ~/.config/uwsm/env-hyprland
-- (HYPR* / AQ_*). Kept here for parity with your previous setup.
hl.env("XCURSOR_SIZE", "10")
hl.env("XCURSOR_THEME", "HyprCatppuccinMochaMauve")
hl.env("HYPRCURSOR_SIZE", "10")
hl.env("HYPRCURSOR_THEME", "HyprCatppuccinMochaMauve")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
--------#
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("NVD_BACKEND", "direct")

--#####################
--### LOOK AND FEEL ###
--#####################
hl.config({
  general = {
    gaps_in                 = 0,
    gaps_out                = 0,
    border_size             = 1,
    resize_on_border        = false,
    allow_tearing           = false,
    layout                  = "dwindle",
    ["col.active_border"]   = "rgba(595959aa) rgba(595959aa) 45deg",
    ["col.inactive_border"] = "rgba(000000ee)",
  },
  decoration = {
    rounding         = 0,
    rounding_power   = 0,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = "rgba(1a1a1aee)",
    },
    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },
  dwindle = {
    pseudotile = true, preserve_split = true,
  },
  master = {
    new_status = "master",
  },
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo   = true,
  },
  input = {
    kb_layout    = "us",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",
    follow_mouse = 1,
    sensitivity  = 0,
    touchpad     = {
      natural_scroll = true,
    },
  },
  cursor = {
    no_hardware_cursors = true,
    enable_hyprcursor   = true,
  },
})

--############################
--### ANIMATIONS (DISABLED) ###
--############################
local ANIMATIONS_ENABLED = false

-- Bezier curves (hl.curve) — equivalent of `bezier = name, p1x, p1y, p2x, p2y`
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1.00 }, { 0.32, 1.00 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1.00 } } })
hl.curve("linear", { type = "bezier", points = { { 0.00, 0.00 }, { 1.00, 1.00 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.50, 0.50 }, { 0.75, 1.00 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0.00 }, { 0.10, 1.00 } } })
hl.curve("bounceEnd", { type = "bezier", points = { { 0.20, 0.80 }, { 0.30, 1.20 } } })

-- Animation tree — equivalent of `animation = LEAF, ON, SPEED, CURVE [, STYLE]`
-- Note: `bezier` arg holds the curve name (named "bezier" in old syntax, can also use `curve`).
hl.animation({ leaf = "global", enabled = ANIMATIONS_ENABLED, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = ANIMATIONS_ENABLED, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = ANIMATIONS_ENABLED, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = ANIMATIONS_ENABLED, speed = 3, bezier = "bounceEnd", style = "slide 100%" })
hl.animation({
  leaf = "windowsOut",
  enabled = ANIMATIONS_ENABLED,
  speed = 1.49,
  bezier = "easeOutQuint",
  style = "slide 100%"
})
hl.animation({ leaf = "fadeIn", enabled = ANIMATIONS_ENABLED, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = ANIMATIONS_ENABLED, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = ANIMATIONS_ENABLED, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = ANIMATIONS_ENABLED, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = ANIMATIONS_ENABLED, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = ANIMATIONS_ENABLED, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = ANIMATIONS_ENABLED, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = ANIMATIONS_ENABLED, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = ANIMATIONS_ENABLED, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = ANIMATIONS_ENABLED, speed = 1.2, bezier = "almostLinear", style = "slide" })
hl.animation({
  leaf = "workspacesOut",
  enabled = ANIMATIONS_ENABLED,
  speed = 1.2,
  bezier = "almostLinear",
  style = "slide"
})

--##############
--## GESTURE ###
--##############
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

--####################
--## PER-DEVICE CFG ##
--####################
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

--###################
--### KEYBINDINGS ###
--###################
hl.bind(mainMod .. " SHIFT + L", hl.dsp.exec_cmd(ydotoolxr))
hl.bind(mainMod .. " SHIFT + H", hl.dsp.exec_cmd(ydotoolxl))
hl.bind(mainMod .. " SHIFT + J", hl.dsp.exec_cmd(ydotoolyu))
hl.bind(mainMod .. " SHIFT + K", hl.dsp.exec_cmd(ydotoolyd))
hl.bind(mainMod .. " SHIFT + Return", hl.dsp.exec_cmd(ydotoolcl))
hl.bind(mainMod .. " SHIFT + BackSpace", hl.dsp.exec_cmd(ydotoolcr))

hl.bind(mainMod .. " SHIFT + mouse:272", hl.dsp.exec_cmd(hyprzoom))

----------------------------------------------------------------------------
-- Core actions
----------------------------------------------------------------------------
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " SHIFT + Q", hl.dsp.kill_active()) -- killactive
-- hl.bind(mainMod .. " + M",            hl.dsp.exit())            -- exit (be careful with uwsm)
-- hl.bind(mainMod .. " + E",            hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" })) -- togglefloating
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())                     -- dwindle pseudo
hl.bind(mainMod .. " + I", hl.dsp.layout("togglesplit"))               -- dwindle
hl.bind(mainMod .. " + O", hl.dsp.layout("swapsplit"))                 -- dwindle
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())                 -- fullscreen

hl.bind(mainMod .. " + backslash", hl.dsp.exec_cmd(grim))
hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd(githubKey))

----------------------------------------------------------------------------
-- Move focus with mainMod + h/j/k/l
----------------------------------------------------------------------------
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

----------------------------------------------------------------------------
-- Switch workspaces with mainMod + [0-9]
-- (CHANGED) Loop replaces 10 manual lines (DRYer; behavior identical).
----------------------------------------------------------------------------
for i = 1, 10 do
  local key = (i == 10) and "0" or tostring(i) -- 0 maps to workspace 10, like before
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " SHIFT + " .. key, hl.dsp.move_to_workspace({ workspace = i }))
end

----------------------------------------------------------------------------
-- Special workspace (scratchpad)
----------------------------------------------------------------------------
hl.bind(mainMod .. " + S", hl.dsp.special_workspace({ name = "magic", action = "toggle" }))
hl.bind(mainMod .. " SHIFT + S", hl.dsp.move_to_workspace({ workspace = "special:magic" }))

----------------------------------------------------------------------------
-- Scroll through workspaces with mainMod + scroll
-- (CHANGED) `mouse_down/mouse_up` mapped to focus({ workspace = "e+1"/"e-1" }).
-- The `e+1` / `e-1` selector means "next/prev existing workspace".
----------------------------------------------------------------------------
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

----------------------------------------------------------------------------
-- Move/resize windows with mainMod + LMB/RMB and dragging
-- (CHANGED) `bindm` becomes `{ mouse = true }`.
----------------------------------------------------------------------------
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
