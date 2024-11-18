#!/bin/bash

# TIME

now="$(printf '%(%Y-%m-%d %H:%M:%S)T\n' -1)"
day="$(echo "$now" | cut -d" " -f1)"
time="$(echo "$now" | cut -d" " -f2 | sed 's/\:/_/g')"
yyyy="$(echo "$day" | cut -d"-" -f1)"
mm="$(echo "$day" | cut -d"-" -f2)"
dd="$(echo "$day" | cut -d"-" -f3)"


# DEFAULTS

build_log_dir () {
  echo "$LOGS_DIR/$yyyy/$mm/$dd/$time"
}

LOGS_DIR="./log"

LOG_DIR=$(build_log_dir)
PROVISION_LOG_PATH="$LOG_DIR/provision.log"
TEST_LOG_PATH="$LOG_DIR/test.log"


# HELPERS

create_log_dir () {
  mkdir -p "$LOG_DIR"
}

log_dir_exists () {
  if [ ! -d "$LOG_DIR" ]; then
    create_log_dir
  fi
}

append_to_output () {
  output="$1"
  message="$2"
  case "$1" in
    p)
      echo "$message" >> $PROVISION_LOG_PATH
      ;;
    t)
      echo "$message" >> $TEST_LOG_PATH
      ;;
    *)
      ;;
  esac
}

log () {
  output="$1"
  severity="$2"
  service="$3"
  message="$4"
  date="$(date '+%Y-%m-%d %H:%M:%S')"
  log_dir_exists
  append_to_output "$output" \
    "$date - $service - $severity - $message" 
}


# INTERFACE

clear_log () {
  output="$1"
  case "$1" in
    p)
      cat /dev/null > $PROVISION_LOG_PATH
      ;;
    t)
      cat /dev/null > $TEST_LOG_PATH
      ;;
    *)
      ;;
  esac
}

debug () {
  output="$1"
  service="$2"
  message="$3"
  log "$output" "debug" "$service" "$message"
}

info () {
  output="$1"
  service="$2"
  message="$3"
  log "$output" "info" "$service" "$message"
}

warn () {
  output="$1"
  service="$2"
  message="$3"
  log "$output" "WARN" "$service" "$message"
}

error () {
  output="$1"
  service="$2"
  message="$3"
  log "$output" "ERROR" "$service" "$message"
}


