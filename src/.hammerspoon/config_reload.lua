local module = {}

module.reloadConfig = function(files)
    local doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then doReload = true end
    end
    if doReload then hs.reload() end
end

module.my_watcher = hs.pathwatcher.new(os.getenv "HOME" .. "/.hammerspoon/", module.reloadConfig):start()

hs.alert.show "Config loaded"

return module
