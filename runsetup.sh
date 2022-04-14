#!/usr/bin/bash 

@echo "Setup the initial app scaffold"
sudo docker-compose run --no-deps web rails new . --force --database=postgresql
sudo chown -R $USER:$USER .
@echo "running bundle in order to install unsatisfied deps. on Gemfile"
sudo docker-compose run --no-deps web bundle
@echo "create db "
sudo docker-compose run --no-deps web rails db:create
docker-compose up