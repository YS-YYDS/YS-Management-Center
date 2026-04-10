local _, source_path = reaper.get_action_context()
local script_path = source_path:match("^(.*[\\/])[^\\/]-$") or ""
local script_name = source_path:match("([^\\/]+)%.lua$")
local bytecode_file = script_path .. (script_name or "YS_智能输入") .. ".dat"
local f = io.open(bytecode_file, "rb")
if not f then bytecode_file = script_path .. "YS_智能输入.dat" f = io.open(bytecode_file, "rb") end
if f then
    local c = f:read("*all"); f:close()
    local fn, err = load(c, "@" .. bytecode_file)
    if fn then local s, r = pcall(fn) if not s then reaper.MB(r, "Error", 0) end return r
    else reaper.MB(err, "Load Error", 0) end
else reaper.MB("Missing: " .. bytecode_file, "Error", 0) end