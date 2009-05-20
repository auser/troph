module Troph
  class PeriodicChecker < BaseCaller
    
    def handle_call
      Troph.send_to_queue(:presence, :heartbeat, {:host => "host"})
    end
    
  end
end