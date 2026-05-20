# Changelog

All notable changes to this project are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/), and this project adheres to
[Semantic Versioning](https://semver.org/).

## [2.2.0] - 2026-05-20

### Added
- Pre-registered the eight specialist roles as plugin agent types in `agents/`
  (`fabric-ba`, `fabric-architect`, `fabric-ux`, `fabric-dev-lead`, `fabric-qa`,
  `fabric-security`, `fabric-devops`, `fabric-docs`). The PM spawns each teammate
  via `subagent_type`, so per-role tool scoping is now enforced (e.g. the Business
  Analyst and Technical Writer no longer get Bash) instead of every specialist
  running as a generic teammate.

### Changed
- Added the `Skill` tool to the roles whose phases load skills (architect, ux,
  dev-lead, qa, docs) and synced the "Your Team" table to the enforced toolsets.

## [2.1.0] - 2026-05-20

### Changed
- Consolidated to a single source of truth under `plugins/fabric-sdlc/`. Removed
  the duplicate top-level `skills/` and `commands/` trees, the redundant root
  `plugin.json`, and the `sync-plugin.sh` script. `validate-plugin.sh` no longer
  diffs two trees.
- Enriched the plugin manifest with `homepage`, `repository`, `license`, and
  `keywords`.

### Added
- Phase Completion Gate: the PM verifies a phase's deliverables exist on disk
  before advancing.
- Agent Teams preflight in Phase 0 — `TeamCreate` runs before any files are
  written, with a clear message if the capability is disabled.
- The delivered project now ships a generated `CLAUDE.md`.
- Fix-loop iteration count is persisted to the progress log so it survives
  context compaction.
- `TaskOutput` and `TaskStop` added to the `/fabric` command's allowed tools.
- Bundled-skills table and a CHANGELOG in the docs.

## [2.0.0]

### Changed
- Reworked plugin packaging and validation.

## [1.7.0]

### Added
- Excalidraw diagramming skill (later removed for licensing).

## [1.6.0]

### Changed
- Improved agent prompt construction and skill path resolution.

## [1.5.0]

### Changed
- Skill invocation made mandatory for all SDLC agents.

## [1.4.0]

### Added
- Skill-invocation instructions embedded directly in every agent prompt.
- Consolidated into a single plugin with auto-discovery for the bundled skills.
- Skill integration and phase-to-skill mapping.

## [1.1.0]

### Added
- E2E and frontend testing in the QA phase via Playwright.
- README with architecture diagrams and animated demo.

## [1.0.0]

### Added
- Initial release: The Fabric — an autonomous SDLC agent team driven by a single
  business objective, with a PM coordinator plus 8 specialist agents.
