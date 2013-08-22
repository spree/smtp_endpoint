require 'spec_helper'

describe SmtpEndpoint do

  def auth
    {'HTTP_X_AUGURY_TOKEN' => 'x123', "CONTENT_TYPE" => "application/json"}
  end

  def app
    described_class
  end

  let(:config) {
    [
      { 'name' => 'smtp.from', 'value' => 'noreply@pero-ict.nl' },
      { 'name' => 'smtp.to', 'value' => 'spree@example.com' },
      { 'name' => 'smtp.options', 'type' => 'list', 'value' => [{
          "address" => "smtp.mandrillapp.com",
          "port" => "587",
          "user_name" => "peter@pero-ict.nl",
          "password" => "G9a30V1XBE5KWVFMg21MnQ"
        }]
      }
    ]
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

  it "should respond to POST 'send'" do
    post '/send', message.to_json, auth
    last_response.status.should == 200
    last_response.body.should match /"message":"email:sent"/
  end
end
