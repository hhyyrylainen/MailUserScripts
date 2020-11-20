# frozen_string_literal: true

require 'pg'

# User database handling
class Database
  UPDATE_PASSWORD_STATEMENT = 'update_passwd'
  INSERT_USER_STATEMENT = 'inser_user'

  def initialize
    @conn = PG.connect(dbname: DB_NAME, user: DB_USER)

    @conn.prepare(
      UPDATE_PASSWORD_STATEMENT,
      'UPDATE ' + USERS_TABLE + ' SET password = $1 WHERE email = $2;'
    )

    @conn.prepare(
      INSERT_USER_STATEMENT,
      'INSERT INTO ' + USERS_TABLE + ' (email, password, maildir, quota) VALUES($1, $2, $3, $4);'
    )
  end

  # New password needs to be dovecot_entry from Password
  def update_password(email, new_password)
    result = @conn.exec_prepared UPDATE_PASSWORD_STATEMENT, [new_password, email]

    result.cmd_tuples == 1
  end

  def insert_user(email, password, quota, directory)
    result = @conn.exec_prepared INSERT_USER_STATEMENT, [email, password, directory, quota]

    result.cmd_tuples == 1
  end
end
