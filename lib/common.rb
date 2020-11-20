require_relative '../config'
require_relative 'password'
require_relative 'database'

@random_password = false

def check_params
  abort "Unhandled parameters: #{ARGV}" unless ARGV.empty?
end

def create_db
  Database.new
end

def handle_password_option
  unless @options[:password]
    @options[:password] = SecureRandom.alphanumeric(RANDOM_PASSWORD_LENGTH)
    @random_password = true
  end
end

def print_password_if_needed
  puts "Generated random password: #{@options[:password]}" if @random_password
end
