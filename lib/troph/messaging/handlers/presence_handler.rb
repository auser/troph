module Troph
  class PresenceHandler < BaseHandler
    queue_name Troph::QUEUES[:presence]
    
    def handle_message msg
      case msg
      when Troph::MESSAGES[:heartbeat]
        # Do stuff here
        puts "Still responding. Send a ping back"        
      else
        puts "Received presence message: #{msg}"
      end      
    end
    
  end
end