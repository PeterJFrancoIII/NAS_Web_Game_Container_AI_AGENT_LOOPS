#!/bin/sh
# Shared helpers for context-pack install, bootstrap, and verify.
# Requires REPO_ROOT to be set before sourcing (see sync-context-pack.sh).
set -eu

context_pack_root() {
  printf '%s\n' "${REPO_ROOT:?REPO_ROOT must be set before sourcing context-pack.sh}"
}

context_pack_agent_dir() {
  printf '%s\n' "$(context_pack_root)/context-pack/agent"
}

context_pack_bootstrap_dir() {
  printf '%s\n' "$(context_pack_root)/context-pack/bootstrap"
}

replace_project_name() {
  file="$1"
  name="$2"
  if [ -f "$file" ]; then
    sed "s/{{PROJECT_NAME}}/$name/g" "$file" > "${file}.tmp"
    mv "${file}.tmp" "$file"
  fi
}

install_agent_pack() {
  target_root="$1"
  agent_dir="$(context_pack_agent_dir)"

  mkdir -p "$target_root"
  target_root="$(CDPATH= cd -- "$target_root" && pwd)"

  cp -R "$agent_dir/.cursor" "$target_root/"
  cp -R "$agent_dir/.claude" "$target_root/"
  mkdir -p "$target_root/scripts"
  cp "$agent_dir/scripts/verify-context-pack.sh" "$target_root/scripts/"
  chmod +x "$target_root/scripts/verify-context-pack.sh"
}

install_bootstrap_stubs() {
  target_root="$1"
  project_name="$2"
  bootstrap_dir="$(context_pack_bootstrap_dir)"

  cp "$bootstrap_dir/MISSION.md" "$target_root/"
  cp "$bootstrap_dir/AGENTS.md" "$target_root/"
  cp "$bootstrap_dir/CLAUDE.md" "$target_root/"
  cp "$bootstrap_dir/README.md" "$target_root/"
  cp "$bootstrap_dir/.gitignore" "$target_root/"
  mkdir -p "$target_root/docs/specs" "$target_root/docs/architecture" "$target_root/docs/ai" "$target_root/docs/handoffs/templates"
  cp "$bootstrap_dir/docs/specs/"* "$target_root/docs/specs/"
  cp "$bootstrap_dir/docs/architecture/system-map.md" "$target_root/docs/architecture/"
  cp "$bootstrap_dir/docs/ai/ai-decision-log.md" "$target_root/docs/ai/"
  cp "$bootstrap_dir/docs/handoffs/templates/handoff-template.md" "$target_root/docs/handoffs/templates/"

  replace_project_name "$target_root/MISSION.md" "$project_name"
  replace_project_name "$target_root/docs/specs/current-objective.md" "$project_name"
  replace_project_name "$target_root/docs/architecture/system-map.md" "$project_name"
  replace_project_name "$target_root/docs/ai/ai-decision-log.md" "$project_name"
}
