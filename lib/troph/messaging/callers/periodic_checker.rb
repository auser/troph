module Troph
  class PeriodicChecker < BaseCaller
    def handle_call
      
      MQ.queue(Troph::QUEUES[:presence]).publish(Troph::MESSAGES[:heartbeat])
      
    end
  end
end