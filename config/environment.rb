# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup

require 'bundler'
Bundler.require

Bundler.setup :default
$: << File.expand_path('../../', __FILE__)

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pg'
require 'active_record'
require 'logger'
# Framework
require 'sinatra'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/support'
require 'sinatra/partial'
# view rendering
require 'slim'
# API response hash / json helper
require 'hashie'
# require 'pry'
require 'yaml'
# Used to create unique account_codes
require 'securerandom'
# Assets
require 'sass'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

require_relative 'application'