module Troph
  class JoinHandler < BaseHandler
    queue_name Troph::QUEUES[:nodes]
    
    def handle_message(type, msg)
      case type
      when :join
        # Do stuff here
        log "I received a join message. Perhaps I should respond!"        
      else
        log "Received join message: #{msg.inspect}"
      end      
    end
    
  end
end