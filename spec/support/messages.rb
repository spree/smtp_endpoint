module Factories
  class << self
    def notification(args={})
      {
        "subject" => "An unexpected error occurrred",
        "description" => "We were unable to process message blah",
        "level" => "error"
      }
    end
  end
end