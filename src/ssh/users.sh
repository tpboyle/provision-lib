#!/bin/bash


# SOURCE


# CONFIG

USERS_CONF_DIR="$SSH_CONF_DIR/users"


# INTERFACE

provision_user () {
  name="$1"
  user_exists "$name"
  users_ssh_is_provisioned "$name"
}

provision_users () {
  for name in "$(list_users)" do
    provision_user $name
  done
}


