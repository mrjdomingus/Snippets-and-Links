# How to configure Postfix (to send email via Gmail)

Complete these steps as **root**.

1. `sudo apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules`<br>
Note: Choose "internet site" and other default options if promted with questions in terminal.<br> Run `sudo dpkg-reconfigure postfix` if you need to reconfigure postfix over.
2. Create your password file with `sudo nano /etc/postfix/sasl_passwd` 
3. Populate the password file. Example: `[smtp.gmail.com]:587 myusername@gmail.com:mypassword`
4. Secure the file by running `sudo chmod 600 /etc/postfix/sasl_passwd`<br>
5. **Replace** the contents of the config file by running `sudo nano /etc/postfix/main.cf`
6. Place the following in the file:
```
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_security_options =
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
```
7. Encode password file by running `sudo postmap /etc/postfix/sasl_passwd`

8. Restart postfix service by running `sudo systemctl restart postfix.service`

9. Replace `you@example.com` with your email adddress in the following code and test sending mail:<br>
`echo "Test mail from postfix" | mail -s "Test Postfix" you@example.com`

10. Give Google a minute to process. You should see the sent mail in your Sent folder for your gmail account and in the inbox of the specified destination account. If the mail doesn't come, check `sudo cat /var/mail/root` or `sudo cat /var/log/mail.log` or [other places depending on your distribution](https://serverfault.com/questions/59602/where-to-check-log-of-sendmail) for errors.

Via: [https://serverfault.com/questions/510251/postfix-gmail-authentication-required-error](https://serverfault.com/questions/510251/postfix-gmail-authentication-required-error)

Also see:
* [How to Send an SMTP Email (via SendGrid)](https://sendgrid.com/docs/API_Reference/SMTP_API/getting_started_smtp.html)
* [Install and configure Postfix on Ubuntu 16.04 with Sendgrid as smarthost](https://linuxmon.com/install-and-configure-postfix-on-ubuntu-1604/)
