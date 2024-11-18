#!/bin/bash


# CONFIG

DUMP_PATH="/tmp/.crontab.tmp"


# HELPERS

dump_crontab () {
  crontab -l > "$DUMP_PATH"
}

flash_cron () {
  crontab "$DUMP_PATH"
}

delete_crontab_dump () {
  rm "$DUMP_PATH"
}

apply_cmd_to_cron () {
  cmd="$1"
  dump_crontab
  flash_cron
  bash -c "$cmd"
  delete_crontab_dump
}

# ACTIONS

add_cron_job () {
  tag="$1"
  cmd="$2"
  apply_cmd_to_cron "echo '$cmd #$tag' >> $DUMP_PATH"
}

delete_cron_job () {
  tag="$1"
  cmd="$2"
  apply_cmd_to_cron "sed '/#$tag/d' $DUMP_PATH > $DUMP_PATH"
}

list_matching_cron_jobs () {
  tag="$1"
  crontab -l | grep "#$tag" 
}


# STATES

cron_job_exists () {
  tag="$1"
  cmd="$2"
  if [ ! -n list_matching_cron_jobs "$tag" ]; then
    add_cron_job "$tag" "$cmd"
  fi
}

