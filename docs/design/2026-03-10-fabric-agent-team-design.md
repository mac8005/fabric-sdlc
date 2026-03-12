# The Fabric Claude Agent Team - Design Document

**Date:** 2026-03-10
**Status:** Approved

## Objective

Fully automate the Software Development Lifecycle (SDLC) using a team of specialized Claude Code agents. The business provides an objective; the team autonomously delivers a fully functional application with complete documentation for traceability.

## Team Composition (9 Agents)

| # | Role | Agent Name | Phase | Runs In |
|---|------|-----------|-------|---------|
| 1 | Project Manager | `fabric-pm` | 0, 7 | Sequential |
| 2 | Business Analyst | `fabric-ba` | 1 | Sequential |
| 3 | Solution Architect | `fabric-architect` | 2 | Parallel with UX |
| 4 | UX/UI Engineer | `fabric-ux` | 2 | Parallel with Architect |
| 5 | Lead Developer | `fabric-dev-lead` | 3, 4-fix | Sequential (parallel sub-agents) |
| 6 | QA Engineer | `fabric-qa` | 4 | Parallel with Security |
| 7 | Security Engineer | `fabric-security` | 4 | Parallel with QA |
| 8 | DevOps Engineer | `fabric-devops` | 5 | Sequential |
| 9 | Technical Writer | `fabric-docs` | 6 | Sequential |

## SDLC Phases

### Phase 0: Project Initiation (fabric-pm)
- Receive business objective
- Create project charter (`docs/00-project-charter.md`)
- Initialize progress log (`docs/00-progress-log.md`)
- Create and assign tasks for all phases

### Phase 1: Requirements Analysis (fabric-ba)
- Analyze business objective
- Produce requirements document (`docs/01-requirements.md`)
- Write user stories with acceptance criteria (`docs/01-user-stories.md`)

### Phase 2: Design (PARALLEL: fabric-architect + fabric-ux)
- **Architect:** System architecture, tech stack, data models, API contracts
  - `docs/02-architecture.md`, `docs/02-tech-stack.md`, `docs/02-api-contracts.md`
- **UX/UI:** Wireframes, UI spec, design system
  - `docs/02b-wireframes.md`, `docs/02b-ui-spec.md`, `docs/02b-design-system.md`

### Phase 3: Implementation (fabric-dev-lead + parallel sub-agents)
- Dev Lead reads architecture + UX specs
- Spawns parallel sub-agents for independent modules
- All code in `src/`, implementation log in `docs/03-implementation-log.md`

### Phase 4: Testing & Security (PARALLEL: fabric-qa + fabric-security)
- **QA:** Test plan, write tests, run tests, document results
  - `docs/04-test-plan.md`, `docs/04-test-results.md`
- **Security:** OWASP review, dependency audit, threat model
  - `docs/04b-security-review.md`, `docs/04b-threat-model.md`

### Phase 4-fix: Feedback Loop (max 3 iterations)
- If critical/high issues found → Dev Lead fixes → QA/Security re-run
- Medium/low issues documented as tech debt (`docs/07-tech-debt.md`)

### Phase 5: Deployment Setup (fabric-devops)
- Build scripts, CI/CD, containerization, deployment configs
- `docs/05-deployment.md`, configs in `infra/`

### Phase 6: Documentation (fabric-docs)
- README.md, user guide, API docs
- `docs/06-user-guide.md`, `docs/06-api-docs.md`

### Phase 7: Final Delivery (fabric-pm)
- Review all documentation for completeness
- Update progress log with final status
- Produce delivery summary

## Monorepo Structure

```
project-root/
├── docs/
│   ├── 00-project-charter.md
│   ├── 00-progress-log.md
│   ├── 01-requirements.md
│   ├── 01-user-stories.md
│   ├── 02-architecture.md
│   ├── 02-tech-stack.md
│   ├── 02-api-contracts.md
│   ├── 02b-wireframes.md
│   ├── 02b-ui-spec.md
│   ├── 02b-design-system.md
│   ├── 03-implementation-log.md
│   ├── 04-test-plan.md
│   ├── 04-test-results.md
│   ├── 04b-security-review.md
│   ├── 04b-threat-model.md
│   ├── 05-deployment.md
│   ├── 06-user-guide.md
│   ├── 06-api-docs.md
│   └── 07-tech-debt.md
├── src/
├── tests/
├── infra/
├── README.md
└── CLAUDE.md
```

## Key Design Decisions

1. **Hybrid sequential + parallel:** Phases run sequentially for traceability; parallelism within phases for speed
2. **Feedback loops:** Max 3 iterations between QA/Security and Dev to prevent infinite cycles
3. **All documentation in MD:** Every phase produces markdown files for full traceability
4. **Monorepo:** Single repo contains code, docs, tests, and infrastructure
5. **Fully autonomous:** No human intervention required after providing the business objective
