#!/usr/bin/env bash
# Configura Gitflow y reglas de protección en un repo de la organización.
# Uso: ./scripts/setup-repo.sh umbraltechdev/<repo>
# Requiere: gh CLI autenticado como owner de la organización.
set -euo pipefail

REPO="${1:?Uso: $0 owner/repo}"
CHECKS='[{"context":"Conventional Commits en el título"},{"context":"Nombre de rama Gitflow"}]'

echo "==> Creando rama develop"
SHA=$(gh api "repos/$REPO/git/ref/heads/main" --jq .object.sha)
gh api "repos/$REPO/git/refs" -f ref=refs/heads/develop -f sha="$SHA" >/dev/null 2>&1 \
  || echo "    develop ya existe"

echo "==> Ajustes del repo"
gh api -X PATCH "repos/$REPO" \
  -F allow_merge_commit=true \
  -F allow_squash_merge=true \
  -F allow_rebase_merge=false \
  -F delete_branch_on_merge=true \
  -F allow_auto_merge=false >/dev/null

echo "==> Ruleset de protección para main y develop"
gh api -X POST "repos/$REPO/rulesets" --input - >/dev/null <<JSON
{
  "name": "gitflow-protegidas",
  "target": "branch",
  "enforcement": "active",
  "conditions": { "ref_name": { "include": ["refs/heads/main", "refs/heads/develop"], "exclude": [] } },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "required_signatures" },
    { "type": "pull_request", "parameters": {
        "required_approving_review_count": 0,
        "dismiss_stale_reviews_on_push": true,
        "require_code_owner_review": false,
        "require_last_push_approval": false,
        "required_review_thread_resolution": true } },
    { "type": "required_status_checks", "parameters": {
        "strict_required_status_checks_policy": true,
        "required_status_checks": $CHECKS } }
  ]
}
JSON

echo "==> Listo: $REPO con main/develop protegidas"
