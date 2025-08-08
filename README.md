# github-agent

> 一份 GitHub 全能專案範本，含指令腳本、CI/CD、Issue/PR 模板、slash 指令與 Agent 提示。

[![CI](https://img.shields.io/badge/CI-GitHub_Actions-success)]()
[![License](https://img.shields.io/badge/license-MIT-informational)]()
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-orange)]()

## 🚀 快速開始
```bash
# 1) 安裝依賴（會自動偵測語言）
make init
# 2) 本地開發
make dev   # 若有定義
# 3) 格式化、靜態檢查、測試
make fmt && make lint && make test
# 4) 建置/文件
make build && make docs
```

## 🧩 指令總表

* `make init`：安裝依賴（Node/Python/Go 自動判斷）
* `make fmt` / `make lint` / `make test`：格式、靜態檢查、測試
* `make build`：建置或打包
* `make docs`：產生文件（Typedoc/Sphinx 等）
* `make release`：依 Conventional Commits 自動決定版本並更新 CHANGELOG
* `make deploy-staging` / `make deploy-prod`：部署（需自備 scripts/deploy.sh）

## 🤖 PR / Issue 工作流

* 建議使用 `feat/fix/chore/docs` 等 Conventional Commits 前置
* 送 PR 會觸發 CI、語法檢查與測試
* 留言支援 Slash 指令：`/test`、`/docs`、`/deploy-staging`、`/agent {json}`

## 🔒 安全與版本

* 保護 `main` 分支、只允許 PR merge
* 發版由 `make release` 或 CI 中的 `semantic-release` 完成

## 📄 授權

MIT（可改）
