#!/usr/bin/env bash
set -euo pipefail

ENV=${1:-staging}
case "$ENV" in
  staging)
    echo "Deploy to STAGING..."
    ;;
  prod)
    echo "Deploy to PROD..."
    ;;
  --rollback)
    echo "Rollback..."
    ;;
  *)
    echo "Usage: $0 {staging|prod|--rollback}"
    exit 1
    ;;
esac
