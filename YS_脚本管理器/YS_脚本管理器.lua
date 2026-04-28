-- @description YS 脚本生态管理中心，支持插件安装、更新与授权管理。
-- @version 0.7.0
-- @author YS
-- @build 2026-04-28 08:31:04
-- @ys_auth_id 0

local function _L() local i=debug.getinfo(1,'S') local p=(i.source:sub(1,1)=='@') and i.source:sub(2) or '' local d=p:match('^(.*[\\/])') or '' local dat_path=d..'YS_脚本管理器.dat' local hf=io.open(dat_path,'rb') if not hf then reaper.MB('无法打开: '..dat_path,'加载错误',0) return end local c=hf:read('*all') hf:close() local f,e=load(c) if f then f() else reaper.MB('无法加载: '..dat_path..'\n错误: '..tostring(e),'加载错误',0) end end _L()