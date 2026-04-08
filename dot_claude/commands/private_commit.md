---
allowed-tools: Bash(git status*), Bash(git diff*), Bash(git add *), Bash(git commit *), Bash(git log*)
description: 변경사항을 분석하여 자동 커밋 메시지 생성 후 커밋
---

## 현재 Git 상태 확인

- 변경된 파일: !`git status --short`
- Staged 변경사항: !`git diff --staged`
- Unstaged 변경사항: !`git diff`
- 최근 커밋 스타일: !`git log --oneline -3`

## 작업 수행

1. 위 변경사항을 분석
2. 변경 내용의 성격 파악 (기능 추가, 버그 수정, 리팩토링 등)
3. 최근 커밋 스타일에 맞춰 명확하고 간결한 커밋 메시지 작성
4. 모든 변경사항을 스테이징하고 커밋 실행
5. 커밋 명령은 반드시 `git commit -m "메시지"` 형태로 직접 실행. `$()`, heredoc, cat 등 서브쉘 사용 금지.
