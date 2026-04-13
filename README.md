# ZEP 바이브 코딩 온보딩

비개발자가 딸깍으로 ZEP 로컬 개발 서버를 실행할 수 있도록 도와주는 Claude Code 스킬입니다.

## 사전 준비 (관리자가 처리)

- [ ] 대상자 GitHub 계정을 `zep-us` Organization에 초대
- [ ] 대상자 PC에 [Claude Code](https://claude.ai/download) 설치

## 사용 방법

Claude Code를 열고 아래 명령어를 붙여넣기 하세요:

```
! curl -fsSL https://raw.githubusercontent.com/zep-us/onboarding/main/install.sh | bash
```

설치가 완료되면 Claude Code에서 입력:

```
/onboarding
```

## 스킬이 하는 일

1. 개발 도구 자동 설치 (Homebrew, git, gh, Node.js v20, pnpm, Infisical CLI)
2. GitHub 로그인 안내
3. zep-client 레포 클론 (~/Desktop/zep-client)
4. Infisical 로그인 안내 (환경변수 자동 세팅)
5. 패키지 설치 (`pnpm install`)
6. 작업 유형 선택 → 로컬 서버 실행
   - **코어**: web-app (3000) + play-app (3001)
   - **퀴즈**: quiz-app (5173)

## 지원 환경

- macOS (Apple Silicon / Intel)
- Claude Code 설치 필요
