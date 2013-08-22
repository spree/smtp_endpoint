require File.expand_path(File.dirname(__FILE__) + '/lib/smtp_sender')
Dir['./lib/**/*.rb'].each { |f| require f }

class SmtpEndpoint < EndpointBase

  set :logging, true

  post '/send' do
    begin
      sender = SmtpSender.new(@message[:payload], @message[:message_id], @config)
      process_result *sender.send
    rescue => exception
      process_result *error_result(exception)
    end
  end

  def error_result(exception)
    return 500, {
      'message_id' => @message[:message_id],
      'payload' => @message[:payload],
      'error' => exception.message,
      'backtrace' => exception.backtrace
    }
  end

end
