-- @description YS 脚本生态管理中心，支持插件安装、更新与授权管理。
-- @version 0.7.0
-- @author YS
-- @build 2026-05-03 02:40:38
-- @ys_auth_id 0

local function _L() local i=debug.getinfo(1,'S') local p=(i.source:sub(1,1)=='@') and i.source:sub(2) or '' local d=p:match('^(.*[\\/])') or '' reaper.SetExtState("YS_Runtime","RootDir",d,true) if reaper.file_exists(d.."Auth/YS_Auth.lua") then reaper.SetExtState("YS_Hub","InstallPath",d,true) end local dat_path=d..'YS_FontManager.dat' local hf=io.open(dat_path,'rb') if not hf then return nil end local c=hf:read('*all') hf:close() local f,e=load(c) if f then return f() end return nil end return _L()