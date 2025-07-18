#!/bin/bash

# Path to the directory containing installation scripts
INSTALLS_DIR="$(dirname "$(realpath "$0")")/installs"
DRY_RUN=false

# Check for --dry-run argument
if [[ " $* " =~ " --dry-run " ]]; then
  DRY_RUN=true
  echo "--- DRY RUN MODE ENABLED ---"
  echo "No commands will be executed. This is a simulation."
  echo "--------------------------"
fi

echo "Starting software installation..."
echo "Searching for scripts in: $INSTALLS_DIR"
echo "---"

# Check if the "installs" directory exists
if [ ! -d "$INSTALLS_DIR" ]; then
  echo "Error: The directory '$INSTALLS_DIR' does not exist."
  echo "Please create this directory and place your installation scripts inside."
  exit 1
fi

# Loop through all .sh files in the "installs" directory
for script in "$INSTALLS_DIR"/*.sh; do
  if [ -f "$script" ]; then
    echo "Processing script: $(basename "$script")..."
    if "$DRY_RUN"; then
      echo "  (DRY RUN) Would execute: $script"
      echo "  (DRY RUN) Content of $(basename "$script"):"
      echo "--- START SCRIPT CONTENT ---"
      cat "$script"
      echo "--- END SCRIPT CONTENT ---"
    else
      echo "  Executing script: $script"
      # Make the script executable and run it
      chmod +x "$script"
      "$script"
      if [ $? -eq 0 ]; then
        echo "✅ $(basename "$script") completed successfully."
      else
        echo "❌ Error during execution of $(basename "$script")."
      fi
    fi
    echo "---"
  fi
done

if "$DRY_RUN"; then
  echo "Dry run complete. No changes were made to your system."
else
  echo "All installations have been attempted."
  echo "Please check the messages above for successes or failures."
fi
