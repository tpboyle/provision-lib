#!/bin/bash


# CHECKS

check_directory_exists () {
  test -d "$path"
}

check_file_exists () {
  test -e "$path"
}


# ACTIONS

create_directory () {
  path="$1"
  mkdir -p "$path"
}

create_file () {
  path="$1"
  directory_exists "$(dirname $path)"
  touch "$path"
}

delete_file () {
  path="$1"
  rm "$path"
}


# STATES

directory_exists () {
  path="$1"
  if [ ! check_directory_exists]; then
    create_directory "$path"
  fi
}

file_exists () {
  path="$1"
  if [ ! check_file_exists "$path" ]; then
    create_file "$path"
  fi
}

file_is_deleted () {
  path="$1"
  if [ check_file_exists "$path" ]; then
    delete_file "$path"
  fi
}


