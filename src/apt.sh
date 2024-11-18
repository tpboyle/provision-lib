#!/bin/bash


# SOURCES

source "$LIB_DIR/log.sh"

source "$LIB_DIR/apt/repositories.sh"
source "$LIB_DIR/apt/keyrings.sh"
source "$LIB_DIR/apt/packages.sh"


# STATES

# NOTE: see "./src/apt/*" for more states.

apt_is_updated () {
  info "apt" "Updating apt cache..."
  sudo apt update > /dev/null
  info "apt" "  ...apt cache update complete."
}


