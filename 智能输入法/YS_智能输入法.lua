-- @description 输入法智能切换，避免中文环境下快捷键冲突，支持自定义窗口规则，可视化控制面板，为创作流提供零干扰输入体验。
-- @version 1.2.1
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
local bytecode_file = script_path .. "YS_智能输入法" .. ".dat"
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
