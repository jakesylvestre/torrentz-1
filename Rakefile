#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end
Rake::Task['test'].comment = "Run all tests"

Rake::TestTask.new('integration') do |t|
  t.libs << 'test'
  t.pattern = "test/integration/*_test.rb"
  t.verbose = true
end
