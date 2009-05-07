require 'rubygems'
require 'vendor/rack/lib/rack.rb'
require 'vendor/sinatra/lib/sinatra.rb'

path = "/home/peterszinek/guitracker.hexagile.com/current"

Sinatra::Application.default_options.merge!(
	:root => path,
	:views => path + '/views',
	:public => path + '/public',
  :run => false,
  :env => :production,
	:raise_errors => true
)

log = File.new("sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

require 'rc-suggestions.rb'
run Sinatra.application