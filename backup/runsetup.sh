#!/usr/bin/bash 
@echo "running bundle in order to install unsatisfied deps. on Gemfile"
sudo docker-compose run --no-deps web bundle
sudo docker-compose run --no-deps web rails new . --force --database=postgresql
sudo chown -R $USER:$USER .


docker-compose up