---
name: builder-onboarding
description: "ZEP 빌더 온보딩. 비개발자가 처음부터 로컬 개발 서버를 실행할 수 있도록 안내한다. 필요한 모든 도구(Homebrew, git, gh, Node.js, pnpm, Infisical)를 자동 설치하고, zep-client 레포 클론 및 패키지 설치 후 로컬 서버를 띄운다. 온보딩, onboarding, /builder-onboarding, 개발환경 세팅, 로컬 서버 켜줘, 처음 시작 등의 요청에 반응한다."
---

# ZEP 바이브 코딩 온보딩

비개발자가 ZEP 로컬 개발 환경을 처음부터 세팅할 수 있도록 단계별로 안내한다.

## 스킬 위치

이 스킬의 셸 스크립트는 `~/.claude/skills/builder-onboarding/scripts/` 에 있다.

## 실행 흐름

아래 단계를 순서대로 진행한다. 각 단계 시작 전 사용자에게 현재 단계와 목적을 한국어로 친절하게 설명한다.

---

### 0단계: 사전 권한 점검

먼저 Homebrew 디렉토리 권한 문제가 있는지 확인한다:

```bash
if [ -d "/opt/homebrew" ] && [ ! -w "/opt/homebrew" ]; then echo "PERMISSION_ISSUE"; else echo "OK"; fi
```

결과가 `PERMISSION_ISSUE`이면 사용자에게 안내한다:

> "Homebrew 폴더 권한을 먼저 수정해야 해요. Mac 기본 터미널을 새로 열어서 (Command+Space → '터미널' 검색) 아래 명령어를 붙여넣고 실행해주세요:"

```
sudo chown -R $(whoami) /opt/homebrew
```

> "Mac 로그인 비밀번호를 입력하라고 뜰 거예요. 입력 시 화면에 표시되지 않는 게 정상이에요. 완료되면 알려주세요!"

사용자가 완료 신호를 보내면 1단계로 진행한다.
결과가 `OK`이면 바로 1단계로 진행한다.

---

### 1단계: 개발 도구 자동 설치

```bash
bash ~/.claude/skills/builder-onboarding/scripts/install-deps.sh
```

- 스크립트 출력을 그대로 보여주되, 완료 후 "모든 도구가 준비됐어요!" 라고 안내한다.
- 오류 발생 시 아래 에러 처리 섹션을 참고한다.

---

### 2단계: GitHub 로그인

사용자에게 다음을 안내한다:

> "이제 GitHub 로그인이 필요해요. 아래 명령어를 실행해주세요:"

```
! gh auth login
```

> "브라우저가 열리면 GitHub 계정으로 로그인하면 돼요. 완료되면 알려주세요!"

사용자가 완료 신호를 보내면 다음 명령으로 확인:
```bash
gh auth status
```
성공 메시지가 보이면 다음 단계로 진행한다.

---

### 3단계: zep-client 클론 + 패키지 설치 준비

**⚠️ 중요:** pnpm install 실행 전에 반드시 4단계(Infisical 로그인)를 먼저 완료해야 한다.
postinstall 스크립트가 Infisical에서 환경변수를 자동으로 가져오기 때문이다.

먼저 클론만 진행한다:

```bash
DEST="$HOME/Desktop/zep-client"
REPO="zep-us/zep-client"

if [ -d "$DEST/.git" ]; then
  git -C "$DEST" pull
else
  gh repo clone "$REPO" "$DEST"
fi
```

완료 후 사용자에게 안내: "레포 다운로드 완료! 이제 환경변수 설정이 필요해요."

---

### 4단계: Infisical 로그인

사용자에게 다음을 안내한다:

> "환경변수 설정을 위해 Infisical 로그인이 필요해요. 아래 명령어를 실행해주세요:"

```
! infisical login
```

> "사내 이메일로 로그인하면 돼요. 완료되면 알려주세요!"

사용자가 완료 신호를 보내면 다음 단계로 진행한다.

---

### 5단계: 패키지 설치

```bash
cd ~/Desktop/zep-client && pnpm install
```

- 처음 실행 시 3~5분 소요될 수 있음을 미리 안내한다.
- 완료 후: "설치 완료! 이제 서버를 켜볼게요 🎉"

---

### 6단계: 작업 유형 선택

사용자에게 묻는다:

> "어떤 작업을 하실 건가요?
> - **코어** — ZEP 메인 서비스 (web-app + play-app)
> - **퀴즈** — ZEP Quiz 서비스"

**코어 선택 시:**
```bash
cd ~/Desktop/zep-client
pnpm run serve:web-app &
pnpm run serve:play-app
```
> "web-app: https://localhost:3000, play-app: https://localhost:3001 에서 열려요!"

**퀴즈 선택 시:**
```bash
cd ~/Desktop/zep-client
pnpm run serve:quiz-app
```
> "quiz-app: https://localhost:5173 에서 열려요!"

브라우저 보안 경고(HTTPS 인증서)가 뜨면: "고급 → 안전하지 않음으로 이동"을 클릭하면 된다고 안내한다.

---

## 에러 처리

| 증상 | 원인 | 해결책 |
|------|------|--------|
| `/opt/homebrew` 권한 오류 | 다른 계정 소유 디렉토리 | `! sudo chown -R $(whoami) /opt/homebrew` (0단계 참고) |
| `EACCES: permission denied` | 디렉토리 권한 문제 | `! sudo chown -R $(whoami) /usr/local/lib /usr/local/bin` |
| `node: command not found` after brew install | PATH 미반영 | `source ~/.zprofile` 또는 터미널 재시작 |
| `gh: command not found` | brew PATH 미반영 | `eval "$(/opt/homebrew/bin/brew shellenv)"` |
| `pnpm install` 중 network error | GitHub Package Registry 토큰 만료 | 개발팀에 `.npmrc` 토큰 갱신 요청 |
| `infisical: command not found` | PATH 미반영 | `brew link infisical` 또는 터미널 재시작 |
| 포트 이미 사용 중 (EADDRINUSE) | 다른 프로세스가 점유 | `lsof -ti:3000 \| xargs kill -9` (포트 번호 변경) |
| `Your token has expired` (Infisical) | 세션 만료 | `infisical login` 재실행 |

에러 메시지를 그대로 보여주고, 위 표를 참고해 한국어로 해결책을 안내한다.
이해하기 어려운 에러는 메시지를 해석해서 쉽게 설명한다.
