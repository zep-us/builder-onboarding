#!/bin/bash
# ZEP 레포 클론 + 패키지 설치 스크립트

set -e

DEST="$HOME/Desktop/zep-client"
REPO="zep-us/zep-client"

echo ""
echo "=== zep-client 레포 설정 ==="
echo ""

# 클론 또는 업데이트
if [ -d "$DEST/.git" ]; then
  echo "✔︎  zep-client 폴더 발견 — 최신 코드로 업데이트 중..."
  git -C "$DEST" pull
  echo "✅ 업데이트 완료"
else
  echo "⏳ zep-client 클론 중 (~/Desktop/zep-client)..."
  gh repo clone "$REPO" "$DEST"
  echo "✅ 클론 완료"
fi

echo ""
echo "⏳ 패키지 설치 중... (처음엔 3~5분 걸릴 수 있어요)"
echo ""

cd "$DEST"
pnpm install

echo ""
echo "=== 설치 완료! ==="
echo ""
