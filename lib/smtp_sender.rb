require 'pony'

class SmtpSender

  attr_accessor :notification, :message_id, :config

  def initialize(payload, message_id, config={})
    @notification = payload['notification']
    @message_id = message_id
    @config = config
  end

  def send

    begin
      Pony.mail(
        to: @config['smtp.to'],
        from: @config['smtp.from'],
        subject: "[LEVEL] #{notification[subject]}",
        body: notification[:description],
        via: :smtp,
        via_options: @config['smtp.options'].first
      )
    rescue => exception
      # catch Pony exception here and return message 500
    end

    # return 200 message here.

  end

end