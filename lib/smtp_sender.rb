require 'pony'

class SmtpSender

  attr_accessor :notification, :message_name, :message_id, :config, :via_options

  def initialize(message, config={})
    @notification = message["payload"]
    @message_id = message["message_id"]
    @message_name = message["message"]
    @config = config
    @via_options = config['smtp.options'].first.with_indifferent_access.symbolize_keys
  end

  def send
    message = nil
    begin
      message = Pony.mail(mail_options)
    rescue => exception
      return 500, {
        'message_id' => @message_id,
        'payload' => {'config' => @config, 'message' => message.inspect},
        'error' => exception.message,
        'backtrace' => exception.backtrace
      }
    end

    return 200, {
      'message_id' => @message_id,
      'messages' => [{ 'message' => 'email:sent', 'payload' => {"status" => "ok"} }]
    }
  end

  def mail_options
    options = {
      to: @config['smtp.to'],
      from: @config['smtp.from'],
      subject: "[#{notification_level}] #{notification['subject']}",
      body: notification[:description],
      via: :smtp,
      via_options: @via_options
    }
    options.merge!({cc: @config['smtp.cc']}) if @config['smtp.cc'].present?
    options.merge!({bcc: @config['smtp.bcc']}) if @config['smtp.bcc'].present?
    options
  end

  def notification_level
    @message_name.split(":").last.upcase
  end

end

