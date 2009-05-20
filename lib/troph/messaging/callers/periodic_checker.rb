module Troph
  class PeriodicChecker < BaseCaller
    
    def handle_call
      # DO STUFF IN HERE
      Troph.send_to_queue("localhost", :presence, :heartbeat, {:host => "#{server.host}"})
    end
    
  end
end