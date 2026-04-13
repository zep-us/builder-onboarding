#!/bin/bash
# ZEP 레포 클론 스크립트

set -e

DEST="$HOME/Desktop/zep-client"
REPO="zep-us/zep-client"

echo ""
echo "=== zep-client 레포 다운로드 ==="
echo ""

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
echo "=== 다운로드 완료! ==="
echo ""
