mission_control_packet:
  project_name: "Zero-Drift Build OS"
  user_objective: >
    Implement the AI System Architect Bootloader as an isolated, reusable
    repository context pack with bootstrap tooling — fully separated from the
    stable Red Alert 2 NAS system.
  current_objective: >
    Install v2.0 context pack, verification scripts, and GitHub CI on branch
    feature/zero-drift-bootloader-os.
  success_criteria:
    - Context pack files exist and pass verify-context-pack.sh
    - bootstrap-project.sh can scaffold a clean target directory
    - New git repo on GitHub with main + feature branch
    - No files imported from synology-ra2-arch
  non_goals:
    - Touch NAS_Web_Game_Container or production RA2 stack
    - Build unrelated application features
    - Install unreviewed MCP servers or skills
  target_users:
    - AI System Architects starting new projects in Cursor AUTO
    - Claude Code sessions with subagents and skills
    - Human maintainers reviewing agent governance
  constraints:
    time: "Initial install — single session"
    budget: "Free tooling only"
    stack: "Markdown, shell, GitHub Actions, Cursor/Claude config"
    compliance: "Least-privilege tool access"
    deployment: "Local bootstrap into target directories"
  assumptions:
    confirmed:
      - Red_Alert2_NAS:Arch is frozen as stable backup on GitHub main
      - Cursor IDE with AUTO mode is primary foreground agent
      - User owns PeterJFrancoIII GitHub account
    unconfirmed:
      - Whether future projects bootstrap from this repo or a published template release
  architecture_hypothesis:
    style: "modular monolith — template repo with copy-based bootstrap"
    main_components:
      - name: "Context Pack"
        responsibility: "MISSION, rules, agents, skills, specs, ADRs, handoffs"
      - name: "Bootstrap CLI"
        responsibility: "Copy and customize context pack into new project dirs"
      - name: "Verification Gate"
        responsibility: "Shell script + CI validating required artifacts"
      - name: "Reference Layer"
        responsibility: "Full bootloader spec on-demand, not always-loaded"
  data_classification:
    public:
      - README, templates, rules, agent definitions
    internal:
      - Handoffs, decision logs, ADRs
    confidential: []
    regulated: []
  integrations:
    required:
      - Git / GitHub
      - Cursor IDE rules (.mdc)
      - Claude Code agents and skills
    optional:
      - MCP servers (read-only, reviewed, per-project allowlist)
      - GitHub Actions CI
      - OpenClaw/ClawdBot gateway (triage only, no source writes)
  risks:
    product:
      - Context pack too heavy for small tasks
      - Agents ignore rules if not scoped correctly
    technical:
      - Bootstrap script overwrites existing project files
      - Rule glob patterns mismatch target project layout
    security:
      - Skills or MCP with excessive permissions
      - Gateway agents writing to source by default
    delivery:
      - Drift between this repo and bootstrapped projects
  verification_plan:
    static_checks:
      - sh scripts/verify-context-pack.sh
    unit_tests: []
    integration_tests:
      - Bootstrap to /tmp test dir and re-run verify
    e2e_tests: []
    manual_acceptance:
      - Open in Cursor; confirm 00-mission.mdc always applies
      - Run architect boot prompt from reference doc Section 0
  first_three_slices:
    - objective: "Install context pack files and reference doc"
      allowed_files:
        - "MISSION.md"
        - "AGENTS.md"
        - "CLAUDE.md"
        - ".cursor/**"
        - ".claude/**"
        - "docs/**"
        - "README.md"
        - ".gitignore"
      forbidden_files:
        - "../Red_Alert2_NAS:Arch/**"
        - "../synology-ra2-arch/**"
      done_when:
        - verify-context-pack.sh passes
    - objective: "Add bootstrap and verify scripts"
      allowed_files:
        - "scripts/**"
        - "templates/**"
        - ".github/**"
      forbidden_files:
        - "MISSION.md content unrelated to bootloader"
      done_when:
        - Bootstrap to temp dir succeeds
        - GitHub workflow validates on push
    - objective: "Git init, branch, push to new GitHub repo"
      allowed_files:
        - ".git/**"
        - "docs/handoffs/**"
        - "docs/ai/ai-decision-log.md"
      forbidden_files:
        - "NAS_Web_Game_Container remote"
      done_when:
        - feature/zero-drift-bootloader-os pushed
        - main branch exists on GitHub
