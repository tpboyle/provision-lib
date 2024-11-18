#!/bin/bash


# CHECKS

check_password_auth_is_disabled () {
  grep /etc/ssh/sshd_config "PasswordAuthentication no"
}


# ACTIONS

disable_password_auth () {
  cat /etc/ssh/sshd_config \
    | sed 's/PasswordAuthentication no/PasswordAuthentication yes/g' \
    | sudo tee /etc/ssh/sshd_config
}

restart_sshd () {
  sudo systemctl restart sshd
}


# STATES

password_auth_is_disabled () {
  if [ ! -n check_password_auth_is_disabled ]; then
    disable_password_auth
    restart_sshd
  fi
}


# INTERFACE

configure_ssh () {
  password_auth_is_disabled
}


