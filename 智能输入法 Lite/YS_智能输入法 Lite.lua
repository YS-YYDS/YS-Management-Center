-- @description 轻量级输入法智能切换，避免中文环境下快捷键冲突，无UI界面，占用资源极少，适合偏好极简工作流的用户。
-- @version 1.3.0
-- @author YS
-- @build 2026-05-07 17:41:48
-- @ys_auth_id 3

local function _L() local i=debug.getinfo(1,'S') local p=(i.source:sub(1,1)=='@') and i.source:sub(2) or '' local d=p:match('^(.*[\\/])') or '' reaper.SetExtState("YS_Runtime","RootDir",d,true) package.path=d..'?.lua;'..d..'Modules/?.lua;'..d..'Auth/?.lua;'..d..'Auth/Passport/?.lua;'..package.path if reaper.file_exists(d..'YS_Auth.lua') then reaper.SetExtState("YS_Hub","InstallPath",d,true) else local parent=d:match('^(.-)[^/\\]+[/\\]$') or '' for i=1,5 do if parent=='' then break end local s=parent..'YS_脚本管理器/' if reaper.file_exists(s..'YS_Auth.lua') then reaper.SetExtState("YS_Runtime","ManagerPath",s,true) break end local up=parent:match('^(.-)[^/\\]+[/\\]$') or '' if up==parent then break end parent=up end end local dat_path=d..'YS_智能输入法 Lite.dat' local hf=io.open(dat_path,'rb') if not hf then reaper.MB('无法打开: '..dat_path,'加载错误',0) return end local c=hf:read('*all') hf:close() local f,e=load(c) if f then f() else reaper.MB('无法加载: '..dat_path..'\n错误: '..tostring(e),'加载错误',0) end end _L()