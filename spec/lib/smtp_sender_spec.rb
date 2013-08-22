require 'spec_helper'

describe SmtpSender do


  let(:config) {
    {
      'smtp.to' => 'me@me.com', 'smtp.from' => 'noreply@me.com', 'smtp.options' => [{
        "address" => "smtp.mandrillapp.com",
        "port" => "587",
        "user_name" => "peter@pero-ict.nl",
        "password" => "G9a30V1XBE5KWVFMg21MnQ"
        }]
    }
  }

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
    via_options_sample = {
      :address => "smtp.mandrillapp.com",
      :port => "587",
      :user_name => "peter@pero-ict.nl",
      :password => "G9a30V1XBE5KWVFMg21MnQ"
      }

    sender = SmtpSender.new(message['payload'], message['message_id'], config)
    sender.via_options.should eql via_options_sample
    sender.via_options[:address].should eql "smtp.mandrillapp.com"
  end

end