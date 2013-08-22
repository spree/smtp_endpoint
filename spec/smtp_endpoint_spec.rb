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
      { 'name' => 'smtp.from', 'value' => 'noreply@spreecommerce.com' },
      { 'name' => 'smtp.to', 'value' => 'spree@example.com' },
      { 'name' => 'smtp.cc', 'value' => 'spree+cc@example.com' },
      { 'name' => 'smtp.bcc', 'value' => 'spree+bcc@example.com' },
      { 'name' => 'smtp.options', 'type' => 'list', 'value' => [Factories.via_options]
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
