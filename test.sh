#!/bin/bash


# PATHS

SRC_DIR="./src"
TEST_DIR="./test"


# SOURCES

source "$SRC_DIR/log.sh"


# MAIN

main () {

}


# EXE

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi


