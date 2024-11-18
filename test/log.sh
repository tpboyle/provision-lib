#!/bin/bash


# SOURCES

source "$SRC_DIR/log.sh"


# TESTS




# CAPABILITIES

can_create_log_dir () {
}

can_log_to_provision_output () {
  can_log_info_to_provision_output
  can_log_warning_to_provision_output
  can_log_error_to_provision_output
}

can_log_to_test_output () {
  can_log_info_to_test_output
  can_log_warning_to_test_output
  can_log_error_to_test_output
}


# INTERFACE

test_log () {
  can_create_log_dir
  can_log_to_provision_output
  can_log_to_test_output
}


