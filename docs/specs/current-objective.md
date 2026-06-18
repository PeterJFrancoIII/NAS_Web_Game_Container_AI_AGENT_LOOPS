mission_control_packet:
  project_name: "Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS"
  user_objective: >
    Govern the NAS Web Game Container system rebuild using the AI System Architect
    Bootloader — refactor the ultra Docker stack, deploy to MediaServer2 for live
    troubleshooting, and preserve the frozen golden master.
  current_objective: >
    Phase 5 CI complete. Bootloader + NAS refactor on feature/ai-agent-loops.
    Next: live troubleshooting and fixes under verify/handoff loop.
  success_criteria:
    - sh scripts/verify-context-pack.sh passes
    - sh scripts/run-deploy-tests.sh passes
    - GitHub Actions CI green on push
    - RA2 ultra stack healthy on MediaServer2 (6081/6082 HTTP 200)
    - Agent edits flow through context-pack/agent + sync-context-pack.sh
  non_goals:
    - Modify Red_Alert2_NAS:Arch or NAS_Web_Game_Container stable repo
    - Touch non-RA2 DSM containers on MediaServer2
    - Always-load full bootloader reference doc into context
  constraints:
    stack: "Docker ultra, Wine, WebRTC UDP, coturn, Synology DS225+"
    deployment: "NAS_HOST=MediaServer2 sh scripts/redeploy-ultra.sh (red-zone)"
    governance: "Bootloader Section 11 repo layer + context-pack single source"
    frozen_reference: "NAS_Web_Game_Container @ golden-master-2026-06-udp-lan"
  architecture_hypothesis:
    style: "modular monolith — NAS app + governance context pack in one repo"
    main_components:
      - name: "Context Pack"
        responsibility: "Bootloader rules, skills, agents — edit context-pack/agent/"
      - name: "NAS Ultra Stack"
        responsibility: "compose, container/, scripts/redeploy-ultra.sh"
      - name: "Archive Layer"
        responsibility: "archive/compose/, archive/container/, scripts/archive/"
      - name: "Verification Gate"
        responsibility: "run-deploy-tests.sh, verify-context-pack.sh"
  verification_plan:
    static_checks:
      - sh scripts/verify-context-pack.sh
    unit_tests:
      - sh scripts/run-webrtc-tests.sh
      - python3 -m pytest tests/
    integration_tests:
      - RA2_COMPOSE_ULTRA=1 sh scripts/compose-stack.sh
    manual_acceptance:
      - curl -k https://peterjfrancoiii2.synology.me:6081/ returns 200
  first_three_slices:
    - objective: "Re-enable bootloader context pack on NAS refactor repo"
      done_when:
        - verify-context-pack.sh passes
        - sync-context-pack.sh run
    - objective: "Phase 5 CI — webrtc tests + pytest on push"
      allowed_files:
        - ".github/**"
        - "docs/specs/nas-container-refactor.md"
      done_when:
        - GitHub workflow green on feature branch
    - objective: "Live troubleshooting under bootloader handoff format"
      allowed_files:
        - "container/**"
        - "scripts/**"
        - "docs/handoffs/**"
      done_when:
        - Issue reproduced, fix verified, handoff written
