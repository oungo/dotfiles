# dotfiles

## 새 맥 설정

### 사전 준비
1. App Store 로그인 (Magnet 설치에 필요)

### 설치

chezmoi가 없는 경우:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply oungo
```

chezmoi가 이미 설치된 경우:

```bash
chezmoi init --apply oungo
```
