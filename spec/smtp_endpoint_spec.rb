require 'spec_helper'

describe SmtpEndpoint do

  let(:config) {
    [
      { 'name' => 'smtp.from', 'value' => 'noreply@system.com' },
      { 'name' => 'smtp.to', 'value' => 'spree@example.com' }
    ]
  }


  let(:message) {
    {
      'store_id' => '123229227575e4645c000001',
      'message_id' => 'abc',
      'payload' => {
        'notification' => Factory.notification,
        'parameters' => config
      }
    }
  }

  def auth
    {'HTTP_X_AUGURY_TOKEN' => 'x123', "CONTENT_TYPE" => "application/json"}
  end

  def app
    SmtpEndpoint
  end

end
