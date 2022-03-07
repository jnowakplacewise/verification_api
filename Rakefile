# frozen_string_literal: true

task :docker_compose do
  sh 'docker-compose up -d'
end

task :install do
  sh 'bundle install'
end

task :tests do
  sh 'bundle exec rspec ./specs'
end

task :clean do
  sh 'docker-compose down'
end

task all: %i[docker_compose install tests clean]
