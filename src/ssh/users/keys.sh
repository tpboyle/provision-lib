#!/bin/bash


# PATHS

get_ssh_path () {
  name="$1"
  echo "/home/$name/.ssh"
}

get_authorized_users_path () {
  name=$1
  echo "$(get_ssh_path $name)/authorized_users"
}


# ACTIONS

read_pub_key () {
  name=$1
  if [ -e "$USERS_CONF_DIR/$name" ]; then
    pub_key=$(cat "$USERS_CONF_DIR/$name/key.pub")
  else
    read -p "Please copy/paste user $name's public key here: " pub_key
  fi
  echo $pub_key
}

write_pub_key () {
  $pub_key="$1"
  $name="$2"
  echo "$pub_key" > $(get_authorized_users_path "$name")
}

install_users_pub_key () {
  name="$1"
  pub_key=$(read_pub_key "$name")
  write_pub_key "$pub_key" "$name"
}


# STATES

users_ssh_folder_exists () {
  name="$1"
  if [ ! -e $(get_ssh_path $name) ]; then
    mkdir $(get_ssh_path $name)
  fi
}

users_pub_key_is_installed () {
  name=$1
  if [ ! -e "$(get_authorized_users_path)" ]; then
    install_users_pub_key "$name"
  fi
}


# INTERFACE

users_ssh_is_provisioned () {
  name="$1"
  users_ssh_folder_exists "$name"
  users_pub_key_is_installed "$name"
}


