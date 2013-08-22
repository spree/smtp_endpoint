require 'spec_helper'

describe SmtpSender do


  let(:config) { Factories.parameters }

  let(:message) {
    {
      'store_id' => '123229227575e4645c000001',
      'message_id' => 'abc',
      'payload' => {
        'notification' => Factories.notification,
        'parameters' => config
      }
    }
  }

  it "set's the correct via_options from config" do
    sender = SmtpSender.new(message['payload'], message['message_id'],config)
    sender.via_options[:address].should eql "smtp.mandrillapp.com"
    sender.mail_options[:bcc].should eql 'me+bcc@me.com'
  end

end