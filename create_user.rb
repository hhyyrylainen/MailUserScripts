#!/usr/bin/env ruby
# frozen_string_literal: true

# Creates a new email user

require 'optparse'

require_relative 'lib/common'

@options = {
  email: nil,
  password: nil,
  quota: DEFAULT_QUOTA,
  directory_name: nil
}

OptionParser.new do |opts|
  opts.banner = "Usage: #{$PROGRAM_NAME} [options]"

  opts.on('-e', '--email email', 'Email address to create') do |email|
    @options[:email] = email
  end
  opts.on('-p', '--password password', 'Password to set for the user, leave blank for random, ' \
                                       '"-" to read from stdin') do |p|
    @options[:password] = p
  end
  opts.on('-q', '--quota quota', 'Quota to set for the user, default: ' + DEFAULT_QUOTA) do |q|
    @options[:quota] = q
  end
  opts.on('-d', '--directory directory', 'Relative directory to store emails, must be unique') do |d|
    @options[:directory_name] = d
  end
end.parse!

check_params

abort 'Must specify email address' unless @options[:email]
abort 'Must specify quota' unless @options[:quota]
abort 'Must specify directory' unless @options[:directory_name]

if @options[:directory_name][-1] != '/'
  abort 'Specified directory must end in a slash'
end

puts "Creating user: #{@options[:email]} with maildir: #{@options[:directory_name]} " +
       "quota: #{@options[:quota]}"

handle_password_option

@password = Password.new(@options[:password])

@db = create_db

abort 'Failed to create user' unless @db.insert_user(
  @options[:email], @password.dovecot_entry, @options[:quota], @options[:directory_name]
)

print_password_if_needed

puts 'User created'
