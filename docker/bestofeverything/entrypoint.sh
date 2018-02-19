#!/bin/bash --login
export PATH="$GEM_HOME/bin:$PATH"
source /usr/local/rvm/scripts/rvm
rvm --default use 2.3.0
nodebrew use v6.12.3
cd /build
exec "$@"
