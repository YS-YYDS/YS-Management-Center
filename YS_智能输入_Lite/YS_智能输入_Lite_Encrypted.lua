-- @description YS 智能输入 (Lite版)
-- @version 1.3.0
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
local bytecode_file = script_path .. "YS_智能输入_Lite_Encrypted" .. ".dat"
if is_win then bytecode_file = bytecode_file:gsub("/", "\\") end

local f = io.open(bytecode_file, "rb")
if f then
    local c = f:read("*all"); f:close()
    local fn, err = load(c, "@" .. bytecode_file)
    if fn then 
        local s, res = pcall(fn)
        if s then return res end
        reaper.MB(tostring(res), "SDK Runtime Error", 0)
    else 
        reaper.MB(tostring(err), "SDK Load Error", 0) 
    end
else
    reaper.MB("组件缺失 (Missing Component):\n" .. bytecode_file, "Build Error", 0)
end
