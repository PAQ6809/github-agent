.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

help: ## 顯示可用指令
	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'

# 偵測語言
HAS_NPM := $(shell [ -f package.json ] && echo 1 || echo 0)
HAS_PY  := $(shell [ -f pyproject.toml -o -f requirements.txt ] && echo 1 || echo 0)
HAS_GO  := $(shell [ -f go.mod ] && echo 1 || echo 0)

init: ## 安裝依賴（自動偵測 Node/Python/Go）
	@if [ $(HAS_NPM) -eq 1 ]; then npm ci || npm i; fi
	@if [ $(HAS_PY)  -eq 1 ]; then pip install -U pip && [ -f requirements.txt ] && pip install -r requirements.txt || true; fi
	@if [ $(HAS_GO)  -eq 1 ]; then go mod download; fi

fmt: ## 格式化
	@if [ $(HAS_NPM) -eq 1 ]; then npm run fmt || true; fi
	@if [ $(HAS_PY)  -eq 1 ]; then ruff format . || true; black . || true; fi
	@if [ $(HAS_GO)  -eq 1 ]; then go fmt ./...; fi

lint: ## 靜態檢查
	@if [ $(HAS_NPM) -eq 1 ]; then npm run lint || true; fi
	@if [ $(HAS_PY)  -eq 1 ]; then ruff check . || true; fi
	@if [ $(HAS_GO)  -eq 1 ]; then golangci-lint run || true; fi

test: ## 測試
	@if [ $(HAS_NPM) -eq 1 ]; then npm test || true; fi
	@if [ $(HAS_PY)  -eq 1 ]; then pytest -q || true; fi
	@if [ $(HAS_GO)  -eq 1 ]; then go test ./...; fi

build: ## 建置/ 打包
	@if [ $(HAS_NPM) -eq 1 ]; then npm run build || true; fi
	@if [ $(HAS_PY)  -eq 1 ]; then python -m build || true; fi
	@if [ $(HAS_GO)  -eq 1 ]; then go build ./...; fi

docs: ## 產生文件
	@if [ -x scripts/gen-docs.sh ]; then ./scripts/gen-docs.sh; else echo "(略)"; fi

release: ## 依 Conventional Commits 自動產版
	npx semantic-release || true

deploy-staging: ## 部署到 Staging（自備腳本）
	./scripts/deploy.sh staging

deploy-prod: ## 部署到 Prod（自備腳本）
	./scripts/deploy.sh prod
