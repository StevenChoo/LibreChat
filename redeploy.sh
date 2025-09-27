#!/usr/bin/env bash
set -e

# Function to display help message
function show_help() {
  echo "LibreChat Deployment Utility"
  echo
  echo "DESCRIPTION:"
  echo "  This utility script deploys LibreChat, optionally cleaning old images."
  echo
  echo "USAGE:"
  echo "  ./redeploy.sh [options]"
  echo
  echo "OPTIONS:"
  echo "    --clean      Remove old images before deployment (optional)"
  echo "    --help, -h   Show this help message"
}

# Check for the --help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  show_help
  exit 0
fi

echo -e "Starting LibreChat Deployment Utility\n"

echo -e "Stopping LibreChat services\n"
docker compose down

# Remove old images if --clean flag is provided
if [ "$1" == "--clean" ]; then
  echo "Removing old LibreChat images\n"
  docker images -a | grep "librechat" | awk '{print $3}' | xargs docker rmi
fi

echo -e "Pulling latest version of LibreChat images\n"
docker compose pull

echo -e "INFO: If you want to clean old images, run the script with the --clean flag after pulling the latest version of the repository.\n\n"
echo -e "Recreating and deploying LibreChat services\n"
docker compose up --force-recreate -d
