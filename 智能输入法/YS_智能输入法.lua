-- @description 输入法智能切换，避免中文环境下快捷键冲突，支持自定义窗口规则，可视化控制面板，为创作流提供零干扰输入体验。
-- @version 1.2.2
-- @author YS / Antigravity
-- @build 2026-04-25 21:05:17
-- @ys_auth_id 1

local function _L() local i=debug.getinfo(1,'S') local p=(i.source:sub(1,1)=='@') and i.source:sub(2) or '' local d=p:match('^(.*[\\/])') or '' local dat_path=d..'YS_智能输入法.dat' local hf=io.open(dat_path,'rb') if not hf then reaper.MB('无法打开: '..dat_path,'加载错误',0) return end local c=hf:read('*all') hf:close() local f,e=load(c) if f then f() else reaper.MB('无法加载: '..dat_path..'\n错误: '..tostring(e),'加载错误',0) end end _L()