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

def handle_password_option
  unless @options[:password]
    @options[:password] = SecureRandom.alphanumeric(RANDOM_PASSWORD_LENGTH)
    puts 'Using randomly generated password'
    @random_password = true
  end

  if @options[:password] == '-'
    password = nil

    loop do
      suppress_echo
      print 'New password: '
      password = STDIN.gets.chomp
      puts ''
      print 'Confirmation: '
      password_confirm = STDIN.gets.chomp
      puts ''
      enable_echo

      break if password == password_confirm

      puts "Passwords don't match! Please retry."
    end

    @options[:password] = password

    abort 'You did not enter a password when prompted' unless @options[:password]
  end
end

def print_password_if_needed
  puts "Generated random password: #{@options[:password]}" if @random_password
end
