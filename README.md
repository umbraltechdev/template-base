# template-base

Plantilla base de UmbralTech para todos los repositorios. Define Gitflow, protección de ramas, convenciones de commits y plantillas de PR e issues.

## Contenido
- `.github/` — CODEOWNERS, plantilla de PR, plantillas de issues y validaciones de PR.
- `scripts/setup-repo.sh` — crea `develop` y aplica las reglas de protección a un repo nuevo.
- `CONTRIBUTING.md` — flujo Gitflow y convención de commits.
- `.editorconfig`, `.gitattributes`, `.gitignore`, `.env.example` — estándares comunes.

## Crear un repo nuevo desde esta plantilla
```bash
gh repo create umbraltechdev/<nombre> --template umbraltechdev/template-base --private --clone
./scripts/setup-repo.sh umbraltechdev/<nombre>
```
