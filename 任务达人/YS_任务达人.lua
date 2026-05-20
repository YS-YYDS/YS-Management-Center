-- @description 便捷管理标记与区间，支持追踪标记位置同步、多标签分类、剪贴板导入导出分享
-- @version 1.0
-- @author YS
-- @build 2026-05-20 13:53:04
-- @ys_auth_id 1005

local function _L() local i=debug.getinfo(1,'S') local p=(i.source:sub(1,1)=='@') and i.source:sub(2) or '' local d=p:match('^(.*[\\/])') or '' reaper.SetExtState("YS_Runtime","RootDir",d,true) package.path=d..'?.lua;'..d..'Modules/?.lua;'..package.path local dat_path=d..'YS_任务达人.dat' local hf=io.open(dat_path,'rb') if not hf then reaper.MB('无法打开: '..dat_path,'加载错误',0) return end local c=hf:read('*all') hf:close() local f,e=load(c) if f then f() else reaper.MB('无法加载: '..dat_path..'\n错误: '..tostring(e),'加载错误',0) end end _L()