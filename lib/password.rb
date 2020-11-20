# frozen_string_literal: true

require 'securerandom'
require 'digest'
require 'base64'

# Dovecot compatible password generation helper
class Password
  def initialize(password, salt = nil)
    salt = SecureRandom.hex(32) if salt.nil?

    @salt = salt
    @password = password
  end

  def password_hash
    Digest::SHA512.digest(@password + @salt)
  end

  def full_hash
    Base64.strict_encode64 password_hash + @salt
  end

  # Generates the needed text for dovecot
  def dovecot_entry
    "{SSHA512}#{full_hash}"
  end
end
