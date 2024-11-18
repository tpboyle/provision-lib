#!/bin/bash


# ACTIONS

add_cron_job () {
  tag="$1"
  cmd="$2"
  cat "su pat; $cmd" > "/etc/cron.weekly/$tag"
}

delete_weekly_cron_job () {
  tag="$1"
  rm "/etc/cron.weekly/$tag"
}

list_matching_weekly_cron_jobs () {
  tag="$1"
  ls /etc/cron.weekly/ | grep "$tag"
}


# STATES

weekly_cron_job_exists () {
  tag="$1"
  cmd="$2"
  if [ ! -n list_matching_weekly_cron_jobs "$tag" ]; then
    add_weekly_cron_job "$tag" "$cmd"
  fi
}

