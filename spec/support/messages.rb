module Factories
  class << self
    def notification(args={})
      {
        "subject" => "order has been imported",
        "description" => "Order R576512345 has been succesfully imported."
      }.merge(args)
    end

    def parameters(args={}, via_options_args={})
      {
        'smtp.to' => 'me@me.com',
        'smtp.from' => 'noreply@me.com',
        'smtp.cc' => 'me+cc@me.com',
        'smtp.bcc' => 'me+bcc@me.com',
        'smtp.options' => [via_options(via_options_args)]
      }.merge(args)
    end

    def via_options(args={})
      {
        "address" => "smtp.mandrillapp.com",
        "port" => "587",
        "user_name" => "peter@spreecommerce.com",
        "password" => "G9a30V1XBE5KWVFMg21MnQ",
        "enable_starttls_auto" => "true",
        "authentication" => "login",
        "domain" => "spreecommerce.com"
      }.merge(args)
    end

  end
end