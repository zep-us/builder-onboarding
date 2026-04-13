# ZEP 빌더 온보딩

 빌더 분들의 원활한 바이브 코딩 시작을 위하여 의존성 설치 및 ZEP 로컬 개발 서버 실행까지 뚝딱 완료해주는 스킬입니다.

## 사전 준비 (수동으로 우선적으로 완료돼있어야하는 것들)

- [ ] 본인 GitHub 계정이 `zep-us` Organization에 초대되어있어야합니다

- [ ] 본인 PC에 [Claude Code](https://claude.ai/download)가 설치되어있어야합니다

- [ ] Infisical에 초대가 되어있어야 합니다

  > 위 사항들은 개발자들의 도움을 받으세요

## 사용 방법

Claude Code를 열고 아래 명령어를 붙여넣기하여 실행하세요:

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
5. 의존성 설치 (`pnpm install`)
6. 작업 유형 선택 → 로컬 서버 실행
   - **코어**: web-app (3000) + play-app (3001)
   - **퀴즈**: quiz-app (5173)

## 지원 환경

- macOS
- Claude Code 설치 필요
