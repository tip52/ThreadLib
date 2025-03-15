--[[
I made this because I was sick of there not being an easy solution

REQUIRED FUNCS:

gettenv (Overwritable): getgenv().overwrite_gettenv = true

getreg

getgc (not needed unless using getthreadfunctions)

]]

local function getScriptFromPath(path)
    local obj = game
    for segment in path:gmatch("[^.]+") do
        obj = obj:FindFirstChild(segment)
        if not obj then return nil end
    end
    return obj
end

local _GCache = {}
local sharedCache = {}

for i, v in ipairs(getreg()) do
    if type(v) == "table" then
        if i == 1 then
            _GCache = v
        elseif i == 4 then
            sharedCache = v
            break
        end
    end
end

local ThreadLib = {}

-- Due to this only returning script, shared, and _G, and not the actual thread env, there is an option to overwrite or not.
if getgenv().overwrite_gettenv then
    local threadEnv = {}
    function ThreadLib.gettenv(thread)
        threadEnv = {}
        local source = debug.info(thread, 1, "s")
        threadEnv.script = nil
        threadEnv.shared = getrenv and getrenv().shared or sharedCache
        threadEnv._G = getrenv and getrenv()._G or _GCache

        if source then
            local scriptInstance = getScriptFromPath(source)
            threadEnv.script = scriptInstance or nil
        end

        return threadEnv
    end
else
    ThreadLib.gettenv = gettenv
end

local threads = {}
function ThreadLib.getallthreads()
    threads = {}
    for i, v in next, getreg() do
        if type(v) == "thread" then
            table.insert(threads, v)
        end
    end
    return threads
end

ThreadLib.getthreads = ThreadLib.getallthreads


function ThreadLib.getscriptfromthread(thread)
    return ThreadLib.gettenv(thread).script
end

ThreadLib.getscriptthread = ThreadLib.getscriptfromthread


local connectedThreads = {}
function ThreadLib.getscriptthreads(script)
    connectedThreads = {}
    for i, v in next, ThreadLib.getthreads() do
        if ThreadLib.getscriptfromthread(v) == script then
            table.insert(connectedThreads, v)
        end
    end
    return connectedThreads
end

function ThreadLib.getfunctionthreads(func)
    local script = getfenv(func).script
    return ThreadLib.getscriptthreads(script)
end

function ThreadLib.getthreadfunction(thread)
    return debug.info(thread, 1, "f") or nil
end

if getgc then
    local threadfuncs = {}
    function ThreadLib.getthreadfunctions(thread)
        threadfuncs = {}
        local script = ThreadLib.gettenv(thread).script

        for _, v in next, getgc() do
            if typeof(v) == "function" then
                local sourceScript = getfenv(v).script
                if sourceScript == script then
                    table.insert(threadfuncs, v)
                end
            end
        end

        return threadfuncs
    end
end



-- add to the environment

for i, v in next, ThreadLib do
    getgenv()[i] = v
end
