-- @description 输入法智能切换，避免中文环境下快捷键冲突，支持自定义窗口规则，可视化控制面板，为创作流提供零干扰输入体验。
-- @version 1.2.2
-- @author YS / Antigravity
-- @build 2026-05-06 13:31:34
-- @ys_auth_id 1

local function _L() local i=debug.getinfo(1,'S') local p=(i.source:sub(1,1)=='@') and i.source:sub(2) or '' local d=p:match('^(.*[\\/])') or '' reaper.SetExtState("YS_Runtime","RootDir",d,true) if reaper.file_exists(d.."Modules/YS_Auth.lua") then reaper.SetExtState("YS_Hub","InstallPath",d,true) else local parent=d:match("^(.-)[^/\\]+[/\\]$") or "" for i=1,5 do if parent=="" then break end local s=parent.."YS_脚本管理器/" if reaper.file_exists(s.."Modules/YS_Auth.lua") then reaper.SetExtState("YS_Runtime","ManagerPath",s,true) break end local up=parent:match("^(.-)[^/\\]+[/\\]$") or "" if up==parent then break end parent=up end end local dat_path=d..'YS_智能输入法.dat' local hf=io.open(dat_path,'rb') if not hf then reaper.MB('无法打开: '..dat_path,'加载错误',0) return end local c=hf:read('*all') hf:close() local f,e=load(c) if f then f() else reaper.MB('无法加载: '..dat_path..'\n错误: '..tostring(e),'加载错误',0) end end _L()