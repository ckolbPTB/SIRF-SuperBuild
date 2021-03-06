#!/usr/bin/env bash
# SIRF external dependencies
apt-get update
apt-get install -y --no-install-recommends \
  hdf5-tools           \
  hdfview              \
  libarmadillo-dev     \
  libboost-all-dev     \
  libfftw3-dev         \
  libgtest-dev         \
  libhdf5-serial-dev   \
  libplplot-dev        \
  libxml2-dev          \
  libxslt-dev          \
  swig
