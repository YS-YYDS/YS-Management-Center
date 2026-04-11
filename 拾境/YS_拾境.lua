-- @description 拾境 - 全方位素材与工程聚合管理中心，支持毫秒级检索与跨工程调度。
-- @version 1.2
-- @ys_auth_id 1001
-- @author YS / Antigravity

local _, source_path = reaper.get_action_context()
local script_path = source_path:match("^(.*[\\/])[^\\/]-$") or ""
local script_name = source_path:match("([^\\/]+)%.lua$")

-- [[ V1.1.2 Loader Hardening ]]
-- 确保在 Windows 环境下使用反斜杠，解决 io.open 对于 UTF-8/空格路径的 Invalid Argument 问题
local is_win = reaper.GetOS():match("Win")
local bytecode_file = script_path .. (script_name or "YS_拾境") .. ".dat"
if is_win then bytecode_file = bytecode_file:gsub("/", "\\") end

local f = io.open(bytecode_file, "rb")
if not f then
    bytecode_file = script_path .. "YS_拾境" .. ".dat"
    if is_win then bytecode_file = bytecode_file:gsub("/", "\\") end
    f = io.open(bytecode_file, "rb")
end

if f then
    local c = f:read("*all"); f:close()
    local fn, err = load(c, "@" .. bytecode_file)
    if fn then local s, e = pcall(fn); if not s then reaper.MB(tostring(e), "Error", 0) end
    else reaper.MB(tostring(err), "Load Error", 0) end
else
    reaper.MB("组件缺失 (Missing Component):\n" .. bytecode_file, "Build Error", 0)
end
