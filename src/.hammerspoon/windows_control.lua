local module = {}

local SkyRocket = hs.loadSpoon "SkyRocket"
local spaces = require "hs.spaces"

module.frameCache = {}

module.toggle_window_maximized = function()
    local win = hs.window.focusedWindow()
    if module.frameCache[win:id()] then
        win:setFrame(module.frameCache[win:id()])
        module.frameCache[win:id()] = nil
    else
        module.frameCache[win:id()] = win:frame()
        win:maximize()
    end
end

-- move current window to the space sp
module.MoveWindowToSpace = function(sp)
    local win = hs.window.focusedWindow() -- current window
    local cur_screen = hs.screen.mainScreen()
    local cur_screen_id = cur_screen:getUUID()
    local all_spaces = spaces.allSpaces()
    local spaceID = all_spaces[cur_screen_id][sp]
    spaces.moveWindowToSpace(win:id(), spaceID)
end

module.units = {
    right30 = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 },
    right50 = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
    right70 = { x = 0.30, y = 0.00, w = 0.70, h = 1.00 },
    left30 = { x = 0.00, y = 0.00, w = 0.30, h = 1.00 },
    left50 = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
    left70 = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 },
    top50 = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
    bot50 = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
    bot80 = { x = 0.00, y = 0.20, w = 1.00, h = 0.80 },
    bot87 = { x = 0.00, y = 0.20, w = 1.00, h = 0.87 },
    bot90 = { x = 0.00, y = 0.20, w = 1.00, h = 0.90 },
    upright30 = { x = 0.70, y = 0.00, w = 0.30, h = 0.50 },
    botright30 = { x = 0.70, y = 0.50, w = 0.30, h = 0.50 },
    upleft70 = { x = 0.00, y = 0.00, w = 0.70, h = 0.50 },
    botleft70 = { x = 0.00, y = 0.50, w = 0.70, h = 0.50 },
    right70top80 = { x = 0.70, y = 0.00, w = 0.30, h = 0.80 },
    maximum = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 },
    center = { x = 0.20, y = 0.10, w = 0.60, h = 0.80 },
}

module.sky = SkyRocket:new {
    -- Opacity of resize canvas
    opacity = 0.3,

    -- Which modifiers to hold to move a window?
    moveModifiers = { "cmd", "ctrl" },

    -- Which mouse button to hold to move a window?
    moveMouseButton = "left",

    -- Which modifiers to hold to resize a window?
    resizeModifiers = { "cmd", "ctrl" },

    -- Which mouse button to hold to resize a window?
    resizeMouseButton = "right",
}

-- Takes a layout definition (e.g. 'layouts.work') and iterates through
-- each application definition, laying it out as speccified
module.runLayout = function(layout)
    for i = 1, #layout do
        local t = layout[i]
        local theapp = hs.application.get(t.name)
        if win == nil then
            hs.application.open(t.app)
            theapp = hs.application.get(t.name)
        end
        local win = theapp:mainWindow()
        local screen = nil
        if t.screen ~= nil then screen = hs.screen.find(t.screen) end
        win:move(t.unit, screen, true)
    end
end
module.layouts = {

    full_coding = {
        { name = "Alacritty", app = "Alacritty.app", unit = module.units.maximum },
    },
    coding = {
        { name = "Firefox", app = "Firefox.app", unit = module.units.left70 },
        { name = "Alacritty", app = "Alacritty.app", unit = module.units.right30 },
    },

    coding_inverse = {
        { name = "Firefox", app = "Firefox.app", unit = module.units.left30 },
        { name = "Alacritty", app = "Alacritty.app", unit = module.units.right70 },
    },
    work = {
        {
            name = "Firefox",
            app = "Firefox.app",
            unit = module.units.maximum,
            screen = "Thunderbolt Display",
        },
    },
}

-- Shortcuts
hs.hotkey.bind({ "alt", "shift" }, tostring(0), function() module.MoveWindowToSpace(10) end)

hs.hotkey.bind({ "alt", "shift" }, "Q", function()
    local win = hs.window.focusedWindow()
    win:application():kill()
end)

hs.hotkey.bind({ "alt", "shift" }, "F", function() module.toggle_window_maximized() end)

for i = 1, 9 do
    hs.hotkey.bind({ "alt", "shift" }, tostring(i), function() module.MoveWindowToSpace(i) end)
end

hs.hotkey.bind({ "alt", "shift" }, "h", function() hs.window.focusedWindow():move(module.units.left50, nil, true) end)
hs.hotkey.bind({ "alt", "shift" }, "j", function() hs.window.focusedWindow():move(module.units.bot50, nil, true) end)
hs.hotkey.bind({ "alt", "shift" }, "k", function() hs.window.focusedWindow():move(module.units.top50, nil, true) end)
hs.hotkey.bind({ "alt", "shift" }, "l", function() hs.window.focusedWindow():move(module.units.right50, nil, true) end)

hs.hotkey.bind("alt", "j", function() hs.window.focusedWindow():focusWindowSouth(nil, false) end)
hs.hotkey.bind("alt", "k", function() hs.window.focusedWindow():focusWindowNorth(nil, false) end)
hs.hotkey.bind("alt", "h", function() hs.window.focusedWindow():focusWindowWest(nil, false) end)
hs.hotkey.bind("alt", "l", function() hs.window.focusedWindow():focusWindowEast(nil, false) end)

return module
