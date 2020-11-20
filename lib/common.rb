# frozen_string_literal: true

require_relative '../config'
require_relative 'password'
require_relative 'database'

@random_password = false

def suppress_echo
  `stty -echo`
end

def enable_echo
  `stty echo`
end

def check_params
  abort "Unhandled parameters: #{ARGV}" unless ARGV.empty?
end

def create_db
  Database.new
end

def generate_random_password
  @options[:password] = SecureRandom.alphanumeric(RANDOM_PASSWORD_LENGTH)
  puts 'Using randomly generated password'
  @random_password = true
end

def password_from_user_confirm
  suppress_echo
  print 'New password: '
  password = STDIN.gets.chomp
  puts ''
  print 'Confirmation: '
  password_confirm = STDIN.gets.chomp
  puts ''
  enable_echo

  [password, password_confirm]
end

def prompt_stdin_password
  password = nil

  loop do
    password, confirm = password_from_user_confirm

    break if password == confirm

    puts "Passwords don't match! Please retry."
  end

  @options[:password] = password

  abort 'You did not enter a password when prompted' unless @options[:password]
end

def handle_password_option
  generate_random_password unless @options[:password]

  prompt_stdin_password if @options[:password] == '-'

  abort "Password can't be less than 12 characters" if @options[:password].size < 12
end

def print_password_if_needed
  puts "Generated random password: #{@options[:password]}" if @random_password
end
