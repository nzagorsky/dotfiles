hs.hotkey.bind({ "alt" }, "return", function()
	hs.execute("open -n /Applications/Alacritty.app")
end)

hs.hotkey.bind({ "alt" }, "e", function()
	hs.execute("open ~")
end)

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

hs.hotkey.bind("alt", "j", function() hs.window.focusedWindow():focusWindowSouth(nil, false) end)
hs.hotkey.bind("alt", "k", function() hs.window.focusedWindow():focusWindowNorth(nil, false) end)
hs.hotkey.bind("alt", "h", function() hs.window.focusedWindow():focusWindowWest(nil, false) end)
hs.hotkey.bind("alt", "l", function() hs.window.focusedWindow():focusWindowEast(nil, false) end)
