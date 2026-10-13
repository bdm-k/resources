--------------------------
--- UNBIND DMS DEFAULT ---
--------------------------

hl.unbind("ALT + space")
hl.unbind("CTRL + ALT + Delete")
hl.unbind("CTRL + SHIFT + R")
hl.unbind("SUPER + 1")
hl.unbind("SUPER + 2")
hl.unbind("SUPER + 3")
hl.unbind("SUPER + 4")
hl.unbind("SUPER + 5")
hl.unbind("SUPER + 6")
hl.unbind("SUPER + 7")
hl.unbind("SUPER + 8")
hl.unbind("SUPER + 9")
hl.unbind("SUPER + CTRL + F")
hl.unbind("SUPER + CTRL + H")
hl.unbind("SUPER + CTRL + I")
hl.unbind("SUPER + CTRL + J")
hl.unbind("SUPER + CTRL + K")
hl.unbind("SUPER + CTRL + L")
hl.unbind("SUPER + CTRL + U")
hl.unbind("SUPER + CTRL + mouse_down")
hl.unbind("SUPER + CTRL + mouse_up")
hl.unbind("SUPER + CTRL + down")
hl.unbind("SUPER + CTRL + left")
hl.unbind("SUPER + CTRL + right")
hl.unbind("SUPER + CTRL + up")
hl.unbind("SUPER + End")
hl.unbind("SUPER + F")
hl.unbind("SUPER + H")
hl.unbind("SUPER + Home")
hl.unbind("SUPER + I")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + M")
hl.unbind("SUPER + N")
hl.unbind("SUPER + O")
hl.unbind("SUPER + P")
hl.unbind("SUPER + Page_Down")
hl.unbind("SUPER + Page_Up")
hl.unbind("SUPER + R")
hl.unbind("SUPER + SHIFT + 1")
hl.unbind("SUPER + SHIFT + 2")
hl.unbind("SUPER + SHIFT + 3")
hl.unbind("SUPER + SHIFT + 4")
hl.unbind("SUPER + SHIFT + 5")
hl.unbind("SUPER + SHIFT + 6")
hl.unbind("SUPER + SHIFT + 7")
hl.unbind("SUPER + SHIFT + 8")
hl.unbind("SUPER + SHIFT + 9")
hl.unbind("SUPER + SHIFT + CTRL + H")
hl.unbind("SUPER + SHIFT + CTRL + J")
hl.unbind("SUPER + SHIFT + CTRL + K")
hl.unbind("SUPER + SHIFT + CTRL + L")
hl.unbind("SUPER + SHIFT + CTRL + down")
hl.unbind("SUPER + SHIFT + CTRL + left")
hl.unbind("SUPER + SHIFT + CTRL + right")
hl.unbind("SUPER + SHIFT + CTRL + up")
hl.unbind("SUPER + SHIFT + E")
hl.unbind("SUPER + SHIFT + F")
hl.unbind("SUPER + SHIFT + H")
hl.unbind("SUPER + SHIFT + I")
hl.unbind("SUPER + SHIFT + J")
hl.unbind("SUPER + SHIFT + K")
hl.unbind("SUPER + SHIFT + L")
hl.unbind("SUPER + SHIFT + N")
hl.unbind("SUPER + SHIFT + P")
hl.unbind("SUPER + SHIFT + Page_Down")
hl.unbind("SUPER + SHIFT + Page_Up")
hl.unbind("SUPER + SHIFT + Slash")
hl.unbind("SUPER + SHIFT + T")
hl.unbind("SUPER + SHIFT + U")
hl.unbind("SUPER + SHIFT + W")
hl.unbind("SUPER + SHIFT + down")
hl.unbind("SUPER + SHIFT + equal")
hl.unbind("SUPER + SHIFT + left")
hl.unbind("SUPER + SHIFT + minus")
hl.unbind("SUPER + SHIFT + right")
hl.unbind("SUPER + SHIFT + up")
hl.unbind("SUPER + T")
hl.unbind("SUPER + U")
hl.unbind("SUPER + V")
hl.unbind("SUPER + W")
hl.unbind("SUPER + mouse_down")
hl.unbind("SUPER + mouse_up")
hl.unbind("SUPER + X")
hl.unbind("SUPER + Y")
hl.unbind("SUPER + bracketleft")
hl.unbind("SUPER + bracketright")
hl.unbind("SUPER + code:20")
hl.unbind("SUPER + code:21")
hl.unbind("SUPER + comma")
hl.unbind("SUPER + down")
hl.unbind("SUPER + equal")
hl.unbind("SUPER + left")
hl.unbind("SUPER + minus")
hl.unbind("SUPER + right")
hl.unbind("SUPER + up")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  general = {
    gaps_in     = 4,
    gaps_out    = 5,
    border_size = 2,
    col         = {
      active_border   = "rgba(f2831fff)",
      inactive_border = "rgba(595959aa)",
    },

    layout = "scrolling",
  },

  scrolling = {
    column_width = 0.4,
    explicit_column_widths = "0.2, 0.25, 0.333, 0.4, 0.5, 0.6, 0.667, 0.75, 1.0",
  },

  input = {
    follow_mouse = 2,

    repeat_delay = 200,
    repeat_rate  = 25,
  },
})


---------------------------
---- KEYBINDS / WINDOW ----
---------------------------

local hyper = "SUPER + ALT + CTRL"
local second_mod = "ALT + SHIFT"

-- Navigation
hl.bind(hyper .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(hyper .. " + n", hl.dsp.focus({ direction = "d" }))
hl.bind(hyper .. " + e", hl.dsp.focus({ direction = "u" }))
hl.bind(hyper .. " + i", hl.dsp.focus({ direction = "r" }))

-- Swap/consume columns, expel windows
hl.bind(hyper .. " + left", hl.dsp.layout("swapcol l"))
hl.bind(hyper .. " + right", hl.dsp.layout("swapcol r"))
hl.bind(second_mod .. " + left", hl.dsp.layout("consume_or_expel prev"))
hl.bind(second_mod .. " + right", hl.dsp.layout("consume_or_expel next"))

-- Resize the column
hl.bind(hyper .. " + minus", hl.dsp.layout("colresize -conf"))
hl.bind(hyper .. " + equal", hl.dsp.layout("colresize +conf"))

-- Move/resize windows with mouse
hl.bind(hyper .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(hyper .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Misc
hl.bind(
  hyper .. " + f",
  hl.dsp.window.float({ actioin = "toggle" }),
  { description = "Toggle floating mode" }
)

hl.bind(
  hyper .. " + SHIFT + f",
  hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
  { description = "Toggle fullscreen" }
)

hl.bind(hyper .. " + period", function()
  hl.config({ scrolling = { focus_fit_method = 0 } })
  hl.dispatch(hl.dsp.layout("focus r"))
  hl.dispatch(hl.dsp.layout("focus l"))
  hl.config({ scrolling = { focus_fit_method = 1 } })
end, { description = "Center the current column" })


------------------------------
---- KEYBINDS / WORKSPACE ----
-----------------------------

-- Switch to or move windows to workspaces 'main', 'sub', 'comm.'
hl.bind(hyper .. " + l", hl.dsp.focus({ workspace = 1 }))
hl.bind(hyper .. " + u", hl.dsp.focus({ workspace = 2 }))
hl.bind(hyper .. " + g", hl.dsp.focus({ workspace = 3 }))
hl.bind(hyper .. " + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(hyper .. " + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(hyper .. " + 3", hl.dsp.window.move({ workspace = 3, follow = false }))


----------------------
--- KEYBINDS / DMS ---
----------------------

hl.bind(
  hyper .. " + slash",
  hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"),
  { description = "Show keybinds cheat sheet"}
)

hl.bind(
  hyper .. " + v",
  hl.dsp.exec_cmd("dms ipc call clipboard toggle"),
  { description = "Show clipboard history" }
)

hl.bind(
  second_mod .. " + F3",
  hl.dsp.exec_cmd("dms ipc call outputs cycleProfile"),
  { description = "Cycle monitor profiles" }
)
