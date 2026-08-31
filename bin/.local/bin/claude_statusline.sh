#!/usr/bin/env python3
"""Claude Code status line.

Reads the status JSON on stdin and prints a single line:
    <model>  <cwd>  <context gauge> <pct>  <used>/<limit>  Σ <session total>

Token figures are derived from the session transcript (JSONL) because the
status payload never carries them directly.
"""
import json
import os
import sys

DEFAULT_LIMIT = 200_000
LARGE_LIMIT = 1_000_000

# ANSI helpers ---------------------------------------------------------------
RESET = "\033[0m"
DIM = "\033[2m"
BOLD = "\033[1m"
FG = {
    "grey": "\033[38;5;245m",
    "blue": "\033[38;5;110m",
    "green": "\033[38;5;114m",
    "yellow": "\033[38;5;179m",
    "red": "\033[38;5;174m",
}


def read_payload():
    try:
        return json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        return {}


def human(n):
    """1234 -> '1.2k', 2_000_000 -> '2.0M'."""
    if n < 1_000:
        return str(n)
    if n < 1_000_000:
        return f"{n / 1_000:.1f}".rstrip("0").rstrip(".") + "k"
    return f"{n / 1_000_000:.1f}".rstrip("0").rstrip(".") + "M"


def shorten_path(path):
    home = os.path.expanduser("~")
    if path == home:
        return "~"
    if path.startswith(home + os.sep):
        return "~" + path[len(home):]
    return path


def parse_transcript(transcript_path):
    """Return (context_tokens, session_tokens).

    context_tokens: window occupancy at the last assistant turn.
    session_tokens: every token processed across all API calls this session.
    """
    context_tokens = 0
    session_tokens = 0
    if not transcript_path or not os.path.isfile(transcript_path):
        return context_tokens, session_tokens

    with open(transcript_path, "r", encoding="utf-8") as fh:
        for raw in fh:
            raw = raw.strip()
            if not raw:
                continue
            try:
                entry = json.loads(raw)
            except (json.JSONDecodeError, ValueError):
                continue
            if entry.get("isSidechain"):
                continue
            usage = entry.get("message", {}).get("usage")
            if not isinstance(usage, dict):
                continue
            window = (
                usage.get("input_tokens", 0)
                + usage.get("cache_creation_input_tokens", 0)
                + usage.get("cache_read_input_tokens", 0)
            )
            context_tokens = window  # last one wins
            session_tokens += window + usage.get("output_tokens", 0)

    return context_tokens, session_tokens


def pick_color(pct):
    if pct >= 80:
        return FG["red"]
    if pct >= 50:
        return FG["yellow"]
    return FG["green"]


def render_gauge(pct, width=14):
    """Return a colored fixed-width progress bar for `pct` (0-100).

    TODO(human): build the bar string.
    - Use `width` cells total; fill `round(pct / 100 * width)` of them (clamp
      to the 0..width range so >100% never overflows).
    - Pick glyphs that look good in a terminal (e.g. filled vs empty blocks).
    - Wrap the filled part in `pick_color(pct)` and reset with RESET; keep the
      empty part dim (`DIM`) so the track stays visible.
    Return just the bar (the caller appends the percentage text).
    """
    filled = max(0, min(width, round(pct / 100 * width)))
    bar = pick_color(pct) + "█" * filled + RESET
    bar += DIM + "░" * (width - filled) + RESET
    return bar


def main():
    data = read_payload()
    model = data.get("model", {}).get("display_name") or "Claude"
    cwd = data.get("workspace", {}).get("current_dir") or data.get("cwd") or os.getcwd()
    context_tokens, session_tokens = parse_transcript(data.get("transcript_path"))

    limit = LARGE_LIMIT if context_tokens > DEFAULT_LIMIT else DEFAULT_LIMIT
    pct = (context_tokens / limit * 100) if limit else 0

    sep = f" {DIM}·{RESET} "
    gauge = render_gauge(pct)
    parts = [
        f"{FG['blue']}{BOLD}{model}{RESET}",
        f"{FG['grey']}{shorten_path(cwd)}{RESET}",
        f"{gauge} {pick_color(pct)}{pct:.0f}%{RESET} "
        f"{DIM}{human(context_tokens)}/{human(limit)}{RESET}",
        f"{DIM}Σ {human(session_tokens)}{RESET}",
    ]
    print(sep.join(parts))


if __name__ == "__main__":
    main()
