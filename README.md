# MailUserScripts
Ruby scripts for dovecot postgresql stored user management

# Requirements

Needs postgresql configured (mostly) as specified in:
- https://www.digitalocean.com/community/tutorials/how-to-set-up-a-postfix-email-server-with-dovecot-dynamic-maildirs-and-lmtp
- https://blog.suenotek.com/post/mail-server-with-postfix-dovecot-and-virtual-users-with-postgresql/

But those approaches need to be combined, table etc. names are assumed from the first link,
but quota support is taken from the second one.

Approach for generating salted passwords is from:
- https://www.tunnelsup.com/using-salted-sha-hashes-with-dovecot-authentication/

# Gems

Needs the following gems:

```sh
gem install pg
```

# Running

The root folder contains the ruby scripts that are meant to be executed from the command line.
Each script prints out help with `-h` flag.
