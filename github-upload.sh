#!/bin/bash
# ============================================
# GitHub 文件上传脚本 - xz-create 仓库
# 使用方法：bash ~/github-upload.sh
# ============================================

REPO="Vincentwong-xz/xz-create"

# 优先读取环境变量，没有则提示输入
if [ -z "$GITHUB_TOKEN" ]; then
  read -rsp "🔑 请输入 GitHub Token（输入时不显示）: " TOKEN
  echo ""
else
  TOKEN="$GITHUB_TOKEN"
fi

# ---- 上传单个文件 ----
upload_file() {
  local local_path="$1"
  local remote_path="$2"
  local message="${3:-update: $remote_path}"

  if [ ! -f "$local_path" ]; then
    echo "❌ 文件不存在：$local_path"
    return 1
  fi

  local content
  content=$(base64 -w 0 "$local_path")

  # 检查远程是否已有该文件（更新时需要 SHA）
  local sha
  sha=$(curl -s \
    -H "Authorization: token $TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/$REPO/contents/$remote_path" \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('sha',''))" 2>/dev/null)

  # 构造请求体
  local body
  if [ -n "$sha" ]; then
    body="{\"message\":\"$message\",\"content\":\"$content\",\"sha\":\"$sha\"}"
  else
    body="{\"message\":\"$message\",\"content\":\"$content\"}"
  fi

  result=$(curl -s -X PUT \
    -H "Authorization: token $TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/$REPO/contents/$remote_path" \
    -d "$body")

  echo "$result" | python3 -c "
import sys, json
d = json.load(sys.stdin)
if 'content' in d:
    print('  ✅ ' + d['content']['name'])
else:
    print('  ❌ ' + d.get('message', str(d)))
"
}

# ---- 同步所有 agents 和 skills ----
sync_copilot() {
  echo ""
  echo "🔄 同步 ~/.copilot/agents ..."
  for f in ~/.copilot/agents/*.agent.md; do
    [ -f "$f" ] || continue
    upload_file "$f" "agents/$(basename $f)" "sync: agents/$(basename $f)"
  done

  echo "🔄 同步 ~/.copilot/skills ..."
  for dir in ~/.copilot/skills/*/; do
    [ -d "$dir" ] || continue
    skill=$(basename "$dir")
    [ -f "$dir/SKILL.md" ] && upload_file "$dir/SKILL.md" "skills/$skill/SKILL.md" "sync: skills/$skill/SKILL.md"
  done

  echo ""
  echo "✅ 全部完成！https://github.com/$REPO"
}

# ---- 菜单 ----
echo ""
echo "╔══════════════════════════════════════╗"
echo "║    GitHub 上传助手 · xz-create       ║"
echo "╠══════════════════════════════════════╣"
echo "║  1) 上传单个文件                     ║"
echo "║  2) 一键同步全部 agents + skills     ║"
echo "╚══════════════════════════════════════╝"
echo ""
read -rp "选择操作 (1/2): " choice

case $choice in
  1)
    read -rp "本地路径（如 ~/.copilot/agents/xxx.agent.md）: " lp
    read -rp "仓库路径（如 agents/xxx.agent.md）: " rp
    read -rp "提交说明（回车跳过）: " msg
    lp="${lp/#\~/$HOME}"
    upload_file "$lp" "$rp" "${msg:-update: $rp}"
    ;;
  2)
    sync_copilot
    ;;
  *)
    echo "❌ 无效选择"
    ;;
esac
