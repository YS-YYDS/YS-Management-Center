import os
import json
import subprocess
from datetime import datetime

# ===================== [简化配置] =====================
# 脚本就在 Released_Scripts 目录下运行
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MANIFEST_NAME = "plugins.json"

# ===================== [工具函数] =====================

def run_git(args):
    try:
        # 使用 powershell 执行以解决编码问题
        cmd = ["git"] + args
        result = subprocess.run(cmd, cwd=BASE_DIR, capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Git Error: {e.stderr}")
        return None

# ===================== [主逻辑] =====================

def main():
    print("🚀 YS Hub 极简同步开始...")
    
    # 1. 加载当前清单
    manifest_path = os.path.join(BASE_DIR, MANIFEST_NAME)
    if not os.path.exists(manifest_path):
        print(f"❌ 错误: 找不到 {MANIFEST_NAME}")
        return

    with open(manifest_path, "r", encoding="utf-8") as f:
        manifest = json.load(f)
    
    # 记录是否有变化
    has_changes = False

    # 2. 扫描目录并同步版本 (可选：如果你希望脚本自动从文件夹名读取版本)
    # 此处假设你手动维护 plugins.json 的版本号，脚本仅负责“登记时间”和“同步云端”
    
    # 3. 更新最后修改时间
    manifest["last_updated"] = datetime.now().strftime("%Y-%m-%d")
    with open(manifest_path, "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)
    print("✅ plugins.json 清单已就绪")

    # 4. Git 操作
    print("\n📦 正在准备提交...")
    run_git(["add", "."])
    
    # 检查是否有内容提交
    status = run_git(["status", "--porcelain"])
    if status:
        commit_msg = f"Release: {datetime.now().strftime('%Y-%m-%d %H:%M')}"
        run_git(["commit", "-m", commit_msg])
        
        print("🌍 正在双推云端 (Gitee/GitHub)...")
        # 直接推送到远端的主分支
        gitee_res = run_git(["push", "gitee", "master:master", "--force"])
        github_res = run_git(["push", "github", "master:main", "--force"])
        
        if gitee_res is not None and github_res is not None:
            print("\n🎉 发布成功！所有内容已同步至云端。")
        else:
            print("\n⚠️ 推送过程中可能出现部分失败，请确认网络连接。")
    else:
        print("✌️ 没有检测到新变化，无需更新。")

if __name__ == "__main__":
    main()
