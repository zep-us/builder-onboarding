#!/bin/bash
# ZEP 개발환경 의존성 설치 스크립트
# 각 도구가 이미 설치되어 있으면 스킵합니다.

set -e

log_step() { echo "⏳ $1..."; }
log_done() { echo "✅ $1"; }
log_skip() { echo "✔︎  $1 (이미 설치됨)"; }

echo ""
echo "=== 개발 도구 설치 시작 ==="
echo ""

# 1. Homebrew
if ! command -v brew &>/dev/null; then
  log_step "Homebrew 설치 중"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Apple Silicon 환경 PATH 설정
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  fi
  log_done "Homebrew 설치 완료"
else
  log_skip "Homebrew"
fi

# 2. git
if ! command -v git &>/dev/null; then
  log_step "git 설치 중"
  brew install git
  log_done "git 설치 완료"
else
  log_skip "git"
fi

# 3. gh (GitHub CLI)
if ! command -v gh &>/dev/null; then
  log_step "GitHub CLI(gh) 설치 중"
  brew install gh
  log_done "gh 설치 완료"
else
  log_skip "gh (GitHub CLI)"
fi

# 4. Node.js v20
NODE_VERSION=$(node --version 2>/dev/null | cut -d. -f1 | tr -d 'v' || echo "0")
if [[ "$NODE_VERSION" -lt 18 ]]; then
  log_step "Node.js v20 설치 중"
  brew install node@20
  brew link node@20 --force --overwrite 2>/dev/null || true
  log_done "Node.js v20 설치 완료"
else
  log_skip "Node.js ($(node --version))"
fi

# 5. pnpm
if ! command -v pnpm &>/dev/null; then
  log_step "pnpm 설치 중"
  brew install pnpm
  log_done "pnpm 설치 완료"
else
  log_skip "pnpm ($(pnpm --version))"
fi

# 6. Infisical CLI
if ! command -v infisical &>/dev/null; then
  log_step "Infisical CLI 설치 중"
  brew install infisical/get-cli/infisical
  log_done "Infisical CLI 설치 완료"
else
  log_skip "Infisical CLI"
fi

# 7. mkcert (로컬 HTTPS 인증서 생성)
if ! command -v mkcert &>/dev/null; then
  log_step "mkcert 설치 중"
  brew install mkcert
  log_done "mkcert 설치 완료 (인증서 등록은 다음 단계에서 진행해요)"
else
  log_skip "mkcert"
fi

echo ""
echo "=== 모든 도구 준비 완료! ==="
echo ""
