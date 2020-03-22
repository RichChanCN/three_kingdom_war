-- luaDebug调试
local breakSocketHandle, debugXpCall = require("LuaDebugjit")("localhost", 7003)
cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakSocketHandle, 0.3, false)

cc.FileUtils:getInstance():setPopupNotify(false)
require("config")
-- CC_USE_DEPRECATED_API = true
require("cocos.init")

-- cclog
cclog = function(...)
    -- print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    debugXpCall()
end

local function main()
    -- 不知道为什么不会读取config.lua自动设置
    cc.Director:getInstance():setDisplayStats(CC_SHOW_FPS)

    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    
    require("declare")
    ---------------

    -- run
    local sceneGame = require("scene.battle_scene").new()
    cc.Director:getInstance():runWithScene(sceneGame)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end