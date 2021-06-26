#!/bin/sh

echo "Running rspec..."
RAILS_ENV=test bundle exec rspec
echo "Running rubocop..."
RAILS_ENV=test bundle exec rubocop
