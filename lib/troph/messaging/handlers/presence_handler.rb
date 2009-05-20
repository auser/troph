module Troph
  class PresenceHandler < BaseHandler
    
    queue_name Troph::QUEUES[:presence]
    
    def handle_message(type, msg)
      case type
      when :heartbeat
        # Do stuff here
        puts "Still responding. Send a ping back"
      else
        puts "Received presence message: #{msg.inspect}"
      end
    end
    
  end
end