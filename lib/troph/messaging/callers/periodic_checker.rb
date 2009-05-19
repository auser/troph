module Troph
  class PeriodicChecker < BaseCaller
    def handle_call
      
      MQ.queue("presence").publish("still there?")
      
    end
  end
end