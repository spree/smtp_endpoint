require 'rubygems'
require 'bundler'

Bundler.require(:default)
require "./smtp_endpoint"
run SmtpEndpoint
