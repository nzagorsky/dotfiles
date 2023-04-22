local frameCache = {}
hs.window.animationDuration = 0 -- Disable animations

-- RELOAD
function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.alert.show("Config loaded")
spaces = require("hs.spaces")

-- move current window to the space sp
function MoveWindowToSpace(sp)
	local win = hs.window.focusedWindow() -- current window
	local cur_screen = hs.screen.mainScreen()
	local cur_screen_id = cur_screen:getUUID()
	local all_spaces = spaces.allSpaces()
	local spaceID = all_spaces[cur_screen_id][sp]
	spaces.moveWindowToSpace(win:id(), spaceID)
end

function toggle_window_maximized()
	local win = hs.window.focusedWindow()
	if frameCache[win:id()] then
		win:setFrame(frameCache[win:id()])
		frameCache[win:id()] = nil
	else
		frameCache[win:id()] = win:frame()
		win:maximize()
	end
end

hs.hotkey.bind("alt", "return", function()
	hs.execute("open -n /Applications/Alacritty.app")
end)

hs.hotkey.bind("alt", "e", function()
	hs.execute("open ~")
end)

hs.hotkey.bind({ "alt", "shift" }, "Q", function()
	local win = hs.window.focusedWindow()
	win:application():kill()
end)

hs.hotkey.bind({ "alt", "shift" }, "F", function()
	toggle_window_maximized()
end)

for i = 1, 9 do
	hs.hotkey.bind({ "alt", "shift" }, tostring(i), function()
		MoveWindowToSpace(i)
	end)
end
hs.hotkey.bind({ "alt", "shift" }, tostring(0), function()
    MoveWindowToSpace(10)
end)

local SkyRocket = hs.loadSpoon("SkyRocket")

sky = SkyRocket:new({
  -- Opacity of resize canvas
  opacity = 0.3,

  -- Which modifiers to hold to move a window?
  moveModifiers = {'cmd', 'ctrl'},

  -- Which mouse button to hold to move a window?
  moveMouseButton = 'left',

  -- Which modifiers to hold to resize a window?
  resizeModifiers = {'cmd', 'ctrl'},

  -- Which mouse button to hold to resize a window?
  resizeMouseButton = 'right',
})
