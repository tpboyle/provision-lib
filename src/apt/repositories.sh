#!/bin/bash


# SOURCES

source "$LIB_DIR/log.sh"


# HELPERS

repository_exists () {
  name="$1"
  ls /etc/apt/sources.list.d | grep "$name"
}


# ACTIONS

build_source_list () {
  keyring="$1"
  repository_url="$2"
  echo "deb \
    [arch=$(dpkg --print-architecture) \
    signed-by=/etc/apt/keyrings/$keyring] \
    $repository_url \
    $(. /etc/os-release && echo "$VERSION_CODENAME") \
    stable"
}

add_source_list () {
  name="$1"
  repository_url="$2"
  info "apt" "Adding source list for $name: $repository_url"
  echo \
    $(build_source_list "$name.asc" "$repository_url") \
      | sudo tee "/etc/apt/sources.list.d/$name.list" > /dev/null
}

install_repository () {
  name="$1"
  repository_url="$2"
  info "apt" "Installing repository $name..."
  add_source_list "$name" "$repository_url"
  add_repository_to_apt "$name"
  info "apt" "  ...repository installed."
}

add_repository_to_apt () {
  repository_name="$1"
  if [ ! -n "$(repository_exists $repository_name)" ]; then
    info "apt" "Adding repository $repository_name to apt."
    sudo add-apt-repository -y "ppa:$repository_name/ppa"
    sudo apt update > /dev/null 
  fi
}


# STATES

repository_is_installed () {
  name="$1"
  url="$2"
  # just update the source file everytime
  install_repository "$name" "$url"
}


