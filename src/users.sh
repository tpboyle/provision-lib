#!/bin/bash


# CHECKS

check_user_is_in_group () {
  name="$1"
  group="$2"
  grep "$group.*?\[$name\]" /etc/group
}


# ACTIONS

list_users () {
  echo "$(ls -? "$USERS_CONF_DIR")"
}

create_user () {
  name="$1"
  groupadd "$name"
  useradd "$name" -g "$name" -m
}

add_user_to_group () {
  name="$1"
  group="$2"
  sudo usermod "$name" -aG "$group"
}

add_sudoer () {
  name="$1"
  add_user_to_group "$name" "sudo"
}


# STATES

user_exists () {
  name=$1
  if [ ! -n "$(user_exists $name)" ]; then
    create_user "$name"
  fi
}

user_is_in_group () {
  name="$1"
  group="$2"
  if [ ! -n $(check_user_is_in_group "$name" "$group") ]; then
    add_user_to_group "$name" "$group"
  fi
}

user_is_sudoer () {
  name="$1"
  user_is_in_group "$name" "sudo"
}


