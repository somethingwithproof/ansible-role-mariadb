#!/bin/bash
# Helper script to test MariaDB replication

# Set defaults
PRIMARY_HOST=${1:-primary}
PRIMARY_PORT=${2:-3306}
REPLICA_HOST=${3:-replica}
REPLICA_PORT=${4:-3306}
USER=${5:-root}
PASSWORD=${6:-molecule_test_password}

# Functions
function log_info() {
  echo "[INFO] $1" || return 1
  return 0
}

function log_error() {
  echo "[ERROR] $1" >&2 || return 1
  return 0
}

function test_primary_connection() {
  log_info "Testing connection to primary at $PRIMARY_HOST:$PRIMARY_PORT..."
  mysql -h "$PRIMARY_HOST" -P "$PRIMARY_PORT" -u "$USER" -p"$PASSWORD" -e "SELECT 1;" > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    log_info "✅ Primary connection successful!"
    return 0
  else
    log_error "❌ Primary connection failed!"
    return 1
  fi
}

function test_replica_connection() {
  log_info "Testing connection to replica at $REPLICA_HOST:$REPLICA_PORT..."
  mysql -h "$REPLICA_HOST" -P "$REPLICA_PORT" -u "$USER" -p"$PASSWORD" -e "SELECT 1;" > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    log_info "✅ Replica connection successful!"
    return 0
  else
    log_error "❌ Replica connection failed!"
    return 1
  fi
}

function check_master_status() {
  log_info "Checking primary server status..."
  MASTER_STATUS=$(mysql -h "$PRIMARY_HOST" -P "$PRIMARY_PORT" -u "$USER" -p"$PASSWORD" -e "SHOW MASTER STATUS\G" 2>/dev/null)
  if [[ $? -eq 0 ]] && [[ -n "$MASTER_STATUS" ]]; then
    log_info "✅ Primary has binary logging enabled:"
    echo "$MASTER_STATUS" | grep -E "File|Position" | sed 's/^/   /'
    return 0
  else
    log_error "❌ Primary does not have binary logging enabled or error occurred!"
    return 1
  fi
}

function check_slave_status() {
  log_info "Checking replica server status..."
  SLAVE_STATUS=$(mysql -h "$REPLICA_HOST" -P "$REPLICA_PORT" -u "$USER" -p"$PASSWORD" -e "SHOW SLAVE STATUS\G" 2>/dev/null)
  if [[ $? -eq 0 ]] && [[ -n "$SLAVE_STATUS" ]]; then
    IO_RUNNING=$(echo "$SLAVE_STATUS" | grep -E "Slave_IO_Running|Replica_IO_Running" | grep -c "Yes")
    SQL_RUNNING=$(echo "$SLAVE_STATUS" | grep -E "Slave_SQL_Running|Replica_SQL_Running" | grep -c "Yes")

    if [[ "$IO_RUNNING" -gt 0 ]] && [[ "$SQL_RUNNING" -gt 0 ]]; then
      log_info "✅ Replica is properly connected to primary!"
      echo "$SLAVE_STATUS" | grep -E "Master_Host|Master_Port|Slave_IO_Running|Slave_SQL_Running|Seconds_Behind_Master|Last_Error|Replica_IO_Running|Replica_SQL_Running" | sed 's/^/   /'
      return 0
    else
      log_error "❌ Replica is not properly connected to primary!"
      echo "$SLAVE_STATUS" | grep -E "Master_Host|Master_Port|Slave_IO_Running|Slave_SQL_Running|Last_Error|Replica_IO_Running|Replica_SQL_Running" | sed 's/^/   /'
      return 1
    fi
  else
    log_error "❌ Could not get replica status or not configured as a replica!"
    return 1
  fi
}

function test_replication() {
  log_info "Testing replication by creating a test table on the primary..."
  TEST_DB="repl_test_$RANDOM"

  # Create test database and table on primary
  mysql -h "$PRIMARY_HOST" -P "$PRIMARY_PORT" -u "$USER" -p"$PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $TEST_DB;" > /dev/null 2>&1
  mysql -h "$PRIMARY_HOST" -P "$PRIMARY_PORT" -u "$USER" -p"$PASSWORD" -e "CREATE TABLE IF NOT EXISTS $TEST_DB.test (id INT PRIMARY KEY AUTO_INCREMENT, value VARCHAR(255));" > /dev/null 2>&1
  mysql -h "$PRIMARY_HOST" -P "$PRIMARY_PORT" -u "$USER" -p"$PASSWORD" -e "INSERT INTO $TEST_DB.test (value) VALUES ('test_replication_value');" > /dev/null 2>&1

  if [[ $? -ne 0 ]]; then
    log_error "❌ Failed to create test data on primary!"
    return 1
  fi

  # Wait for replication to catch up
  log_info "Waiting for replication to catch up (10s max)..."
  for _ in {1..20}; do
    sleep 0.5
    REPLICA_DATA=$(mysql -h "$REPLICA_HOST" -P "$REPLICA_PORT" -u "$USER" -p"$PASSWORD" -e "SELECT COUNT(*) FROM $TEST_DB.test WHERE value='test_replication_value';" 2>/dev/null)
    if [[ $? -eq 0 ]] && [[ -n "$REPLICA_DATA" ]] && [[ "$REPLICA_DATA" =~ 1 ]]; then
      log_info "✅ Data successfully replicated!"

      # Clean up test data
      mysql -h "$PRIMARY_HOST" -P "$PRIMARY_PORT" -u "$USER" -p"$PASSWORD" -e "DROP DATABASE $TEST_DB;" > /dev/null 2>&1
      return 0
    fi
  done

  log_error "❌ Data was not replicated to the replica within timeout!"
  return 1
}

# Main execution
log_info "MariaDB Replication Test"
log_info "======================="
log_info "Primary: $PRIMARY_HOST:$PRIMARY_PORT"
log_info "Replica: $REPLICA_HOST:$REPLICA_PORT"
log_info "User: $USER"
log_info "======================="

# Run tests
test_primary_connection
PRIMARY_CONN_RESULT=$?

test_replica_connection
REPLICA_CONN_RESULT=$?

if [[ $PRIMARY_CONN_RESULT -eq 0 ]] && [[ $REPLICA_CONN_RESULT -eq 0 ]]; then
  check_master_status
  MASTER_RESULT=$?

  check_slave_status
  SLAVE_RESULT=$?

  if [[ $MASTER_RESULT -eq 0 ]] && [[ $SLAVE_RESULT -eq 0 ]]; then
    test_replication
    REPL_RESULT=$?

    if [[ $REPL_RESULT -eq 0 ]]; then
      log_info "✅ All replication tests passed!"
      exit 0
    else
      log_error "❌ Replication data test failed!"
      exit 1
    fi
  else
    log_error "❌ Replication configuration test failed!"
    exit 1
  fi
else
  log_error "❌ Connection test failed. Aborting further tests."
  exit 1
fi
