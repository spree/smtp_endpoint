require 'pony'

class SmtpSender

  attr_accessor :notification, :message_id, :config, :via_options

  def initialize(payload, message_id, config={})
    @notification = payload['notification']
    @message_id = message_id
    @config = config
    @via_options = config['smtp.options'].first.with_indifferent_access.symbolize_keys
  end

  def send
    begin
      Pony.mail({
          to: @config['smtp.to'],
          from: @config['smtp.from'],
          subject: "[#{notification['level']}] #{notification['subject']}",
          body: notification[:description],
          via: :smtp,
          via_options: @via_options
        }
      )
    rescue => exception
      return 500, {
        'message_id' => @message_id,
        'payload' => @config,
        'error' => exception.message,
        'backtrace' => exception.backtrace
      }
    end

    return 200, {
      'message_id' => @message_id,
      'messages' => [{ 'message' => 'email:sent', 'payload' => {"status" => "ok"} }]
    }
  end

end