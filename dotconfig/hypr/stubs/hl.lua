---@meta
-- Minimal Hyprland Lua API stub for LSP diagnostics & autocomplete.
-- This is a FALLBACK if /usr/share/hypr/stubs/ is not available on your system.
-- Reference: https://wiki.hypr.land/Configuring/

---@class hl
---@field dsp hl.dsp
hl = {}

---Set global Hyprland config options.
---@param opts table
function hl.config(opts) end

---Define a monitor.
---@param opts { output: string, mode?: string, position?: string, scale?: number|string, mirror?: string, bitdepth?: integer, disabled?: boolean }
function hl.monitor(opts) end

---Set an environment variable (before display server init).
---@param key string
---@param value string
function hl.env(key, value) end

---Run a shell command once at startup.
---@param cmd string
function hl.exec_once(cmd) end

---Define a bezier or spring curve.
---@param name string
---@param opts table
function hl.curve(name, opts) end

---Define an animation node in the animation tree.
---@param opts { leaf: string, enabled?: boolean|integer, speed?: number, bezier?: string, curve?: string, spring?: string, style?: string }
function hl.animation(opts) end

---Define a touchpad/touchscreen gesture.
---@param opts { fingers: integer, direction: string, action: string, mod?: string, scale?: number }
function hl.gesture(opts) end

---Per-device input config.
---@param opts table
function hl.device(opts) end

---Define a workspace rule.
---@param opts table
function hl.workspace_rule(opts) end

---Define a window rule.
---@param opts table
function hl.window_rule(opts) end

---Define a layer rule.
---@param opts table
function hl.layer_rule(opts) end

---Bind a key combination to a dispatcher or function.
---@param keys string
---@param dispatcher any|function
---@param flags? { mouse?: boolean, locked?: boolean, repeating?: boolean, release?: boolean, description?: string, devices?: table }
function hl.bind(keys, dispatcher, flags) end

---Unbind a previously-bound key.
---@param keys string
function hl.unbind(keys) end

---Dispatch an action immediately (instead of binding to a key).
---@param dispatcher any
function hl.dispatch(dispatcher) end

---Subscribe to a Hyprland event.
---@param event string
---@param callback fun(...)
function hl.on(event, callback) end

---Get current value of a config option (e.g. "general.layout").
---@param path string
---@return any
function hl.get_config(path) end

---Get the currently active window.
---@return table|nil
function hl.get_active_window() end

---Define a submap (modal keymap).
---@param name string
---@param body fun()
function hl.define_submap(name, body) end

---Run a function after a timeout (or on interval).
---@param fn fun()
---@param opts { timeout: integer, type?: string }
function hl.timer(fn, opts) end

-- ---------------------------------------------------------------------------
-- hl.dsp (dispatchers) — return tables to be fed into hl.bind / hl.dispatch
-- ---------------------------------------------------------------------------
---@class hl.dsp
local _dsp = {}

function _dsp.exec_cmd(cmd) end
function _dsp.exec_raw(s) end
function _dsp.kill_active() end
function _dsp.exit() end
function _dsp.focus(opts) end
function _dsp.workspace(opts) end
function _dsp.move_to_workspace(opts) end
function _dsp.special_workspace(opts) end
function _dsp.layout(args) end
function _dsp.dpms(opts) end
function _dsp.submap(name) end
function _dsp.pass(window) end
function _dsp.send_shortcut(opts) end

---@class hl.dsp.window
_dsp.window = {}
function _dsp.window.float(opts) end
function _dsp.window.fullscreen(opts) end
function _dsp.window.pseudo(opts) end
function _dsp.window.drag() end
function _dsp.window.resize(opts) end
function _dsp.window.cycle_next() end
function _dsp.window.bring_to_top() end
function _dsp.window.tag(opts) end

---@class hl.dsp.group
_dsp.group = {}
function _dsp.group.toggle() end
function _dsp.group.lock() end

hl.dsp = _dsp

return hl
