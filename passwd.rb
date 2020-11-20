#!/usr/bin/env ruby
# frozen_string_literal: true

# Set a password for user. If password not given sets a random 64 character one

require 'optparse'
require 'securerandom'

require_relative 'lib/common'

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

check_params

abort 'Must specify target email' unless @options[:email]

handle_password_option

puts "Changing password for: #{@options[:email]}"

@password = Password.new(@options[:password])

@db = create_db

abort 'Failed to update password in DB' unless @db.update_password(
  @options[:email], @password.dovecot_entry
)

print_password_if_needed

puts 'Password changed'
