# Flujo de trabajo (Gitflow)

## Ramas
| Rama | Sale de | Se integra a | Uso |
|---|---|---|---|
| `main` | — | — | Producción. Solo recibe `release/*` y `hotfix/*`. |
| `develop` | `main` | — | Integración. Base de todo desarrollo. |
| `feature/<ticket>-<desc>` | `develop` | `develop` | Funcionalidad nueva. |
| `bugfix/<ticket>-<desc>` | `develop` | `develop` | Corrección no urgente. |
| `release/x.y.z` | `develop` | `main` y `develop` | Estabilización de una versión. |
| `hotfix/x.y.z` | `main` | `main` y `develop` | Corrección urgente en producción. |

Nadie hace push directo a `main` ni a `develop`: todo entra por Pull Request.

## Commits (Conventional Commits)
`tipo(alcance): descripción en presente`

Tipos: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `ci`, `perf`.
Ejemplo: `feat(api): agrega endpoint de consulta de saldos`

El **título del PR** debe seguir el mismo formato; se valida automáticamente.

## Versionado
SemVer `MAJOR.MINOR.PATCH`. Al cerrar un `release/*` o `hotfix/*`, se crea el tag `vX.Y.Z` sobre `main`.
