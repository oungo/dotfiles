---
allowed-tools: Bash(git log*), Bash(git reset*), Bash(git commit*)
description: 최근 n개의 커밋을 하나로 스쿼시
---

인자: $ARGUMENTS

## 작업 수행

1. 인자를 파싱한다:
   - 첫 번째 인자: 스쿼시할 커밋 수 `n` (필수, 2 이상 정수)
   - `-m "메시지"` 옵션: 커밋 메시지 (생략 시 최근 커밋 메시지 사용)
   - 인자가 없거나 n이 2 미만이면 사용법을 출력하고 중단한다: `사용법: /squash <n> [-m "메시지"]`

2. Bash 도구로 스쿼시할 커밋 목록을 확인한다 (n은 파싱한 정수값):
   `git log --oneline -<n>`

3. `-m` 옵션이 없으면 Bash 도구로 N개 커밋 메시지를 모두 가져온다:
   `git log --format="%H %s" -<n>`

   그런 다음 가장 중요한 작업을 대표하는 메시지를 다음 기준으로 선택한다:
   - **Prefix 우선순위**: `feat` > `fix` > `refactor` > `chore` > 그 외
   - **동일 prefix면**: 변경 규모(파일/라인 수)가 큰 커밋을 선택 (`git diff --shortstat <hash>^..<hash>`)
   - 단순 보조 작업(파일 제거, 샘플 추가 등)보다 기능 구현/버그 수정을 우선

4. Bash 도구로 다음 두 명령을 순서대로 실행한다:
   - `git reset --soft HEAD~<n>`
   - `git commit -m "<커밋메시지>"`

5. 완료 후 Bash 도구로 결과를 출력한다:
   `git log --oneline -3`
