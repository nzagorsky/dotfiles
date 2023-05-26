local module = {}

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
