#!/bin/bash

set -e

bundle exec rake db:create db:migrate
bundle exec rails s -p 3000 -b 0.0.0.0
