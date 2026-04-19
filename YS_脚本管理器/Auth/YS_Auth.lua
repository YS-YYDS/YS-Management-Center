-- @description YS_Auth
-- @version 1.0.1
-- @ys_auth_id 0
-- @author YS / Antigravity
local function _YS_GetScriptPath()
    local info = debug.getinfo(1, "S")
    local path = (info.source:sub(1,1) == "@") and info.source:sub(2) or ""
    if path == "" then
        local _, ctx_path = reaper.get_action_context()
        path = ctx_path
    end
    return path:gsub("\\", "/"):match("^(.*[\\/])") or ""
end

local is_win = reaper.GetOS():match("Win")
local script_path = _YS_GetScriptPath()
local bytecode_file = script_path .. "YS_Auth" .. ".dat"
if is_win then bytecode_file = bytecode_file:gsub("/", "\\") end

local f = io.open(bytecode_file, "rb")
if f then
    local c = f:read("*all"); f:close()
    local fn, err = load(c, "@" .. bytecode_file)
    if fn then 
        local function err_handler(err) return debug.traceback(tostring(err), 2) end
        local s, res = xpcall(fn, err_handler)
        if s then return res end
        reaper.ShowConsoleMsg("\n================ [SDK FATAL ERROR] ================\n")
        reaper.ShowConsoleMsg("File:   " .. bytecode_file .. "\n")
        reaper.ShowConsoleMsg("Error:  " .. tostring(res) .. "\n")
        reaper.ShowConsoleMsg("===================================================\n")
        reaper.MB("程序发生运行时错误！\n\n我们在 REAPER 控制台输出了详细的错误栈及引发位置（包含行号）。\n请查看控制台并排查源码。\n\n简要报错: " .. tostring(res):sub(1, 200) .. "...", "SDK Runtime Error", 0)
    else 
        reaper.MB(tostring(err), "SDK Load Error", 0) 
    end
else
    reaper.MB("组件缺失 (Missing Component):\n" .. bytecode_file, "Build Error", 0)
end
