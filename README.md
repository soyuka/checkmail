# Check IMAP mails

## Story

At work we use an outlook external service. I'm working on debian and I tried Thunderbird and Evolution with no success. So, I decided to use a custom made script to notify me when my inboxes are holding new messages. I then check them out on a webmail interface.

## How does this work?

It's executing an IMAP telnet with credentials and sends a few `STATUS (unseen)` commands, the result is a number of unseen mails. Coupled with a bash that calls `notify-send` it does the trick. 
To make it work, all you need is some cron:

```
*/1 * * * * /bin/bash /path/to/mailcheck/notifymail.bash example@example.com:S3Cr#t@webmail.example.com >> /home/abluchet/mailcheck/notfymail.log
```

Command argument is of the format:

`user:pass@server:port` 

- `port` is optional and defaulted to 143
- `user` can be an email address

## This may not fit your needs

I've done this in a hurry, there is a regexp test rule on the inbox name (`checkmail:62`):

```
  regexp {(INBOX\/(?!Informatique).*)} $rec -> inbox
```

You may want to see the output (set `log_user = 1`) to get your inboxes and set your own rules.

## Licence

WTFPL
