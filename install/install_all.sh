#!/bin/bash
set -uo pipefail

INSTALLS_DIR="$(dirname "$(realpath "$0")")/installs"
DRY_RUN=false
SCRIPT_ARGS=()

show_help() {
  echo "Usage: $(basename "$0") [options] [script_name...]"
  echo
  echo "Installs various tools and configurations from the 'installs' directory."
  echo "If no script names are provided, it runs all available scripts."
  echo
  echo "Options:"
  echo "  --dry-run          Simulate the installation process without executing any commands."
  echo "  -h, --help         Display this help message and exit."
  echo
  echo "Available scripts:"
  if [ -d "$INSTALLS_DIR" ]; then
    mapfile -t scripts < <(find "$INSTALLS_DIR" -maxdepth 1 -type f -name "*.sh" -exec basename {} .sh \; | sort)
    if [ ${#scripts[@]} -gt 0 ]; then
      for script in "${scripts[@]}"; do
        echo "  $script"
      done
    else
      echo "  No scripts found in '$INSTALLS_DIR'."
    fi
  else
    echo "  'installs' directory not found."
  fi
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    -h|--help)
      show_help
      ;;
    *)
      SCRIPT_ARGS+=("$1")
      shift
      ;;
  esac
done

if "$DRY_RUN"; then
  echo "--- DRY RUN MODE ENABLED ---"
  echo "No commands will be executed. This is a simulation."
  echo "--------------------------"
fi

echo "Starting software installation..."
echo "---"

if [ ! -d "$INSTALLS_DIR" ]; then
  echo "Error: The directory '$INSTALLS_DIR' does not exist."
  exit 1
fi

SCRIPTS_TO_RUN=()
if [ ${#SCRIPT_ARGS[@]} -gt 0 ]; then
  echo "Running selected scripts..."
  for arg in "${SCRIPT_ARGS[@]}"; do
    script_name="$arg"
    if [[ ! "$script_name" == *.sh ]]; then
      script_name+=".sh"
    fi
    
    script_path="$INSTALLS_DIR/$script_name"
    if [ -f "$script_path" ]; then
      SCRIPTS_TO_RUN+=("$script_path")
    else
      echo "⚠️ Warning: Script '$script_name' not found in '$INSTALLS_DIR'. Skipping."
    fi
  done
else
  echo "No specific scripts provided. Running all scripts in '$INSTALLS_DIR'..."
  readarray -t SCRIPTS_TO_RUN < <(find "$INSTALLS_DIR" -maxdepth 1 -type f -name "*.sh")
fi

if [ ${#SCRIPTS_TO_RUN[@]} -eq 0 ] || [ ! -e "${SCRIPTS_TO_RUN[0]}" ]; then
    echo "No scripts to run. Exiting."
    exit 0
fi

echo "---"

for script in "${SCRIPTS_TO_RUN[@]}"; do
    echo "Processing script: $(basename "$script")..."
    if "$DRY_RUN"; then
      echo "  (DRY RUN) Would execute: $script"
      echo "  (DRY RUN) Content of $(basename "$script"):"
      echo "--- START SCRIPT CONTENT ---"
      cat "$script"
      echo "--- END SCRIPT CONTENT ---"
    else
      echo "  Executing script: $script"
      chmod +x "$script"
      if "$script"; then
        echo "✅ $(basename "$script") completed successfully."
      else
        echo "❌ Error during execution of $(basename "$script")."
      fi
    fi
    echo "---"
done

if "$DRY_RUN"; then
  echo "Dry run complete. No changes were made to your system."
else
  echo "All installations have been attempted."
  echo "Please check the messages above for successes or failures."
fi
