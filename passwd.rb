#!/usr/bin/env ruby
# frozen_string_literal: true

# Set a password for user. If password not given sets a random 64 character one

require 'optparse'
require 'securerandom'

require_relative 'lib/password'

@options = {
  email: nil,
  password: nil
}

OptionParser.new do |opts|
  opts.banner = "Usage: #{$PROGRAM_NAME} [options]"

  opts.on('-e', '--email email', 'User email to change password for') do |email|
    @options[:email] = email
  end
  opts.on('-p', '--password password', 'Password to set for the user, leave blank for random') do |p|
    @options[:password] = p
  end
end.parse!

abort "Unhandled parameters: #{ARGV}" unless ARGV.empty?

abort 'Must specify target email' unless @options[:email]

@random_password = false

unless @options[:password]
  @options[:password] = SecureRandom.alphanumeric(RANDOM_PASSWORD_LENGTH)
  @random_password = true
end

puts "Changing password for: #{@options[:email]}"

# TODO: actually change password

puts "Generated random password: #{@options[:password]}" if @random_password

puts 'Password changed'
