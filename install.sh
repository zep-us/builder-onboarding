#!/bin/bash
set -e

SKILL_DIR="$HOME/.claude/skills/vibe-onboarding"
REPO_RAW="https://raw.githubusercontent.com/zep-us/onboarding/main"

echo ""
echo "🚀 ZEP 바이브 코딩 온보딩 스킬을 설치합니다..."
echo ""

mkdir -p "$SKILL_DIR/scripts"

curl -fsSL "$REPO_RAW/skills/vibe-onboarding/SKILL.md" -o "$SKILL_DIR/SKILL.md"
curl -fsSL "$REPO_RAW/skills/vibe-onboarding/scripts/install-deps.sh" -o "$SKILL_DIR/scripts/install-deps.sh"
curl -fsSL "$REPO_RAW/skills/vibe-onboarding/scripts/setup-repo.sh" -o "$SKILL_DIR/scripts/setup-repo.sh"

chmod +x "$SKILL_DIR/scripts/install-deps.sh"
chmod +x "$SKILL_DIR/scripts/setup-repo.sh"

echo "✅ 스킬 설치 완료!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  이제 Claude Code에서 아래를 입력해주세요:"
echo ""
echo "  /onboarding"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
