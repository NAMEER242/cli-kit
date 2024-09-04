#!/bin/bash

set -e

. "$APPLICATION_MANAGER_DIR/common"
. "$APPLICATION_DIR/utils/healthchecks_io"

# Path to the .env file
ENV_FILE="$APPLICATION_DIR/.env"

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
  log error ".env file not found! in the application directory"
  exit 1
fi

# Source the .env file to load environment variables
source "$ENV_FILE"

check() {
  local ping_url=$(validate_check "$HC_API_KEY" "$HC_API_URL" "$HC_CHECK_NAME")
  echo "test: $ping_url"
  if [ -z "$ping_url" ]; then
    log error "check validation failed!!"
    exit 1
  fi

  # Execute the MySQL command to check if the database is running
  mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;" >/dev/null 2>&1

  # Check the response of the MySQL command
  if [ $? -eq 0 ]; then
    log ok "MySQL is up and running."

    # Send a request to the health check service
    curl -fsS -m 10 --retry 5 -o /dev/null "$ping_url"
    if [ $? -eq 0 ]; then
      log ok "Health check ping sent successfully."
    else
      log error "Failed to send health check ping."
    fi
  else
    log error "MySQL is not running."
  fi
}
check
