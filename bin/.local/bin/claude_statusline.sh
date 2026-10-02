#!/usr/bin/env bash
# Claude Code status line: line 1 = workspace/git, line 2 = model/context/cost/quotas.
PATH="$HOME/.local/share/mise/shims:$PATH"

RESET=$'\e[0m' DIM=$'\e[2m' BOLD=$'\e[1m'
RED=$'\e[31m' GREEN=$'\e[32m' YELLOW=$'\e[33m' BLUE=$'\e[34m' MAGENTA=$'\e[35m' CYAN=$'\e[36m'

threshold_color() {
  local pct=$1
  if (( pct >= 80 )); then printf '%s' "$RED"
  elif (( pct >= 50 )); then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"; fi
}

progress_bar() {
  local pct=$1 width=${2:-10} filled i bar=""
  filled=$(( (pct * width + 50) / 100 ))
  (( filled > width )) && filled=$width
  for (( i = 0; i < width; i++ )); do
    if (( i < filled )); then bar+="▓"; else bar+="░"; fi
  done
  printf '%s' "$bar"
}

human_tokens() {
  local n=$1
  if (( n >= 1000000 )); then printf '%dM' $(( n / 1000000 ))
  elif (( n >= 1000 )); then printf '%dk' $(( n / 1000 ))
  else printf '%d' "$n"; fi
}

git_segment() {
  local dir=$1 branch dirty ahead behind out
  git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null || return
  branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
  [[ -z $branch ]] && branch=$(git -C "$dir" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  dirty=$(git -C "$dir" --no-optional-locks status --porcelain 2>/dev/null | wc -l)
  read -r behind ahead < <(git -C "$dir" --no-optional-locks rev-list --left-right --count '@{u}...HEAD' 2>/dev/null)
  out="${MAGENTA} ${branch}${RESET}"
  (( dirty > 0 )) && out+=" ${YELLOW}●${dirty}${RESET}"
  (( ${ahead:-0} > 0 )) && out+=" ${CYAN}↑${ahead}${RESET}"
  (( ${behind:-0} > 0 )) && out+=" ${CYAN}↓${behind}${RESET}"
  printf '%s' "$out"
}

main() {
  local input dir model effort ctx_pct ctx_size ctx_used cost five_pct five_reset week_pct
  input=$(cat)
  IFS=$'\t' read -r dir model effort ctx_pct ctx_size ctx_used cost five_pct five_reset week_pct < <(
    jq -r '[
      .workspace.current_dir // .cwd,
      .model.display_name,
      .effort.level // "",
      (.context_window.used_percentage // 0 | floor),
      .context_window.context_window_size // 0,
      ((.context_window.current_usage // {}) | (.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0)),
      (.cost.total_cost_usd // 0),
      (.rate_limits.five_hour.used_percentage // "" | tostring),
      (.rate_limits.five_hour.resets_at // "" | tostring),
      (.rate_limits.seven_day.used_percentage // "" | tostring)
    ] | @tsv' <<<"$input"
  )

  local line1="${BLUE}${BOLD} ${dir/#$HOME/\~}${RESET}" git_info
  git_info=$(git_segment "$dir")
  [[ -n $git_info ]] && line1+="  ${git_info}"

  local ctx_color line2
  ctx_color=$(threshold_color "$ctx_pct")
  line2="${BOLD}${model}${RESET}"
  [[ -n $effort ]] && line2+="${DIM} · ${effort}${RESET}"
  line2+="  ${ctx_color}$(progress_bar "$ctx_pct") ${ctx_pct}%${RESET}"
  line2+="${DIM} $(human_tokens "$ctx_used")/$(human_tokens "$ctx_size")${RESET}"
  line2+="  $(printf '$%.2f' "$cost")"
  if [[ -n $five_pct ]]; then
    line2+="  $(threshold_color "$five_pct")5h ${five_pct}%${RESET}"
    [[ -n $five_reset ]] && line2+="${DIM} ↻$(date -d "@$five_reset" +%H:%M)${RESET}"
  fi
  [[ -n $week_pct ]] && line2+="  $(threshold_color "$week_pct")7j ${week_pct}%${RESET}"

  printf '%s\n%s\n' "$line1" "$line2"
}

[[ ${BASH_SOURCE[0]} == "$0" ]] && main
