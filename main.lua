--[[
I made this because I was sick of there not being an easy solution

REQUIRED FUNCS:

gettenv
getreg

]]


local ThreadLib = {}

function ThreadLib.getscriptfromthread(thread)
    return gettenv(thread).script
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

local connectedThreads = {}
function ThreadLib.getscriptthreads(script)
    connectedThreads = {}
    for i, v in next, ThreadLib.getthreads() do
        if ThreadLib.getscriptfromthread(v) == script then
            table.insert(connectedThreads,v)
        end
    end
    return connectedThreads
end 

function ThreadLib.getfunctionthreads(func)
    local script = getfenv(func).script
    return ThreadLib.getscriptthreads(script)
end 

for i, v in next, ThreadLib do
    getfenv()[i] = v
end 
