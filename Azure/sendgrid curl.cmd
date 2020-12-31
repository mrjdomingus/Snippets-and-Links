curl --request POST ^
  --url https://api.sendgrid.com/v3/mail/send ^
  --header "Authorization: Bearer $SENDGRID_API_KEY" ^
  --header 'Content-Type: application/json' ^
  --data '{"personalizations": [{"to": [{"email": "mrjdomingus@gmail.com"}]}],"from": {"email": "domingus@xs4all.nl"},"subject": "Sending with SendGrid is Fun","content": [{"type": "text/plain", "value": "and easy to do anywhere, even with cURL"}]}'
