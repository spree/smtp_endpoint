# SMTP Endpoint

Send plain text email via SMTP (GMail, Sendgrid, etc.) using notification messages as the input.

* Receives notification (info, warn, error) messages and sends the notification to the configured recipients.

# Message Format

The subject of the mail will always be the same as the notification subject, with the level (info, warn or error) as an suffix in brackets. for example: ```[WARN] Disk space is low```

The body of the email will be the description posted with the notification message and will be send in plain text format.

# SMTP

We use the [pony](https://github.com/benprew/pony) gem internally and always configure pony to use smtp as the transport method. Also see [pony docs](https://github.com/benprew/pony#transport).

# Parameters

|key | value |
|----|-------|
|```smtp.from```| The from address |
|```smtp.to```| The recipient address, add multiple addresses separated by comma |
|```smtp.cc```| The CC address, add multiple addresses separated by comma|
|```smtp.bcc```| The BCC address, add multiple addresses separated by comma|
|```smtp.options```| the configuration for the smtp 'via_options'|

## Sample message

```json
{
  "store_id":"1234",
  "message_id":"abc",
  "message":"notification:info",
  "payload":{
    "subject":"This is an info notification",
    "description":"You just received an info notification, live long and prosper!",
    "parameters":[
      {
        "name":"smtp.from",
        "type":"string",
        "value":"noreply@spreecommerce.com"
      },
      {
        "name":"smtp.to",
        "type":"string",
        "value":"spree@example.com"
      },
      {
        "name":"smtp.cc",
        "type":"string",
        "value":"spree+cc@example.com"
      },
      {
        "name":"smtp.bcc",
        "type":"string",
        "value":"spree+bcc@example.com"
      },
      {
        "name":"smtp.options",
        "type":"list",
        "value":[
          {
            "address":"smtp.mandrillapp.com",
            "port":"587",
            "user_name":"peter@spreecommerce.com",
            "password":"p4ssw0rd!",
            "enable_starttls_auto":"true",
            "authentication":"login",
            "domain":"spreecommerce.com"
          }
        ]
      }
    ]
  }
}
```

# Local testing
```
ENDPOINT_KEY=123 unicorn
```
Make sure you set the same key in the augury_admin mapping as well.

The url is
```
http://localhost:8080/send
```