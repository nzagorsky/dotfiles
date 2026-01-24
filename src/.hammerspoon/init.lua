hs.hotkey.bind({ "alt" }, "return", function()
	hs.execute("open -n /Applications/Alacritty.app")
end)

hs.hotkey.bind({ "alt" }, "e", function()
	hs.execute("open ~")
end)

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
