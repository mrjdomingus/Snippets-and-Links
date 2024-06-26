# How to configure Postfix (to send email via Gmail)

Complete these steps as **root**.

1. `sudo apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules`<br>
Note: Choose "Internet Site" and other default options if prompted with questions in terminal.<br> Run `sudo dpkg-reconfigure postfix` should you need to reconfigure postfix afterwards.
2. **Replace** the contents of the Postfix config file by running `sudo nano /etc/postfix/main.cf` and replace entirely with the content of [Working-sample-of-Postfix-main.cf](https://raw.githubusercontent.com/mrjdomingus/Snippets-and-Links/master/Ubuntu/Working-sample-of-Postfix-main.cf)
3. Make the appropriate changes in `/etc/postfix/main.cf` as indicated in the file, i.e. change `myhostname` and `smtp_sasl_password_maps` and `relayhost`.
4. Restart Postfix service by running `sudo systemctl restart postfix.service`
5. Verify that TCP port #25 is in LISTENing state on 127.0.0.1: `netstat -tulpn | grep :25`
6. Replace `you@example.com` with your email adddress in the following code and test sending mail:<br>
`echo "Test mail from postfix" | mail -s "Test Postfix" you@example.com` (Gmail should work)
6. Verify that email has been sent or not using your own log file: `sudo tail -f /var/log/mail.log` OR by running `sudo journalctl -u postfix`.


The above supersedes the lesser alternative below.

1. `sudo apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules`<br>
Note: Choose "Internet Site" and other default options if prompted with questions in terminal.<br> Run `sudo dpkg-reconfigure postfix` if you need to reconfigure postfix over.
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

8. Restart the Postfix service by running `sudo systemctl restart postfix.service`

9. Replace `you@example.com` with your email adddress in the following code and test sending mail:<br>
`echo "Test mail from postfix" | mail -s "Test Postfix" you@example.com`

10. Give Google a minute to process. You should see the sent mail in your Sent folder for your gmail account and in the inbox of the specified destination account. If the mail doesn't come, check `sudo cat /var/mail/root` or `sudo cat /var/log/mail.log` or [other places depending on your distribution](https://serverfault.com/questions/59602/where-to-check-log-of-sendmail) for errors.

Via: [https://serverfault.com/questions/510251/postfix-gmail-authentication-required-error](https://serverfault.com/questions/510251/postfix-gmail-authentication-required-error)

Also see:
* [How to Send an SMTP Email (via SendGrid)](https://sendgrid.com/docs/API_Reference/SMTP_API/getting_started_smtp.html)
* [Install and configure Postfix on Ubuntu 16.04 with Sendgrid as smarthost](https://linuxmon.com/install-and-configure-postfix-on-ubuntu-1604/)
* [Configure Postfix to Send Mail Using Gmail and Google Apps on Debian or Ubuntu](https://www.linode.com/docs/email/postfix/configure-postfix-to-send-mail-using-gmail-and-google-apps-on-debian-or-ubuntu/)
* [Sending Emails With Python](https://realpython.com/python-send-email/)
* [SendGrid API Keys](https://sendgrid.com/docs/ui/account-and-settings/api-keys/)
* [Github repo for sendgrid-python](https://github.com/sendgrid/sendgrid-python/blob/master/sendgrid/helpers/mail/mail.py)
* [SendGrid v3 API Python Code Example](https://sendgrid.com/docs/for-developers/sending-email/v3-python-code-example/)
* [How to Send Email Using SendGrid with Azure](https://docs.microsoft.com/en-us/azure/sendgrid-dotnet-how-to-send-email)
* [How to redirect local root mail to an external email address on Linux](https://blog.bobbyallen.me/2013/02/03/how-to-redirect-local-root-mail-to-an-external-email-address-on-linux/)
* [Postfix Basic Setup Howto](https://help.ubuntu.com/community/PostfixBasicSetupHowto)
* [How to Flush Postfix Mail Queue](https://tecadmin.net/flush-postfix-mail-queue/)
* [How to configure Postfix relayhost (smarthost) to send eMail using an external smptd](https://www.cyberciti.biz/faq/how-to-configure-postfix-relayhost-smarthost-to-send-email-using-an-external-smptd/)

