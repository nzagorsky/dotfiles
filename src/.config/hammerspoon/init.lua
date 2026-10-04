local alacritty = "/opt/homebrew/bin/alacritty"

hs.hotkey.bind({ "alt" }, "return", function()
    hs.task.new(alacritty, function(exitCode)
        if exitCode ~= 0 then
            hs.application.launchOrFocus("Alacritty")
        end
    end, {"msg", "create-window"}):start()
end)

hs.hotkey.bind({ "alt" }, "e", function()
	hs.execute("open ~")
end)

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

hs.hotkey.bind("alt", "j", function() hs.window.focusedWindow():focusWindowSouth(nil, false) end)
hs.hotkey.bind("alt", "k", function() hs.window.focusedWindow():focusWindowNorth(nil, false) end)
hs.hotkey.bind("alt", "h", function() hs.window.focusedWindow():focusWindowWest(nil, false) end)
hs.hotkey.bind("alt", "l", function() hs.window.focusedWindow():focusWindowEast(nil, false) end)
