module Troph
  class JoinHandler < BaseHandler
    queue_name Troph::QUEUES[:nodes]
    
    def handle_message msg
      case msg
      when Troph::JOIN_MSG
        # Do stuff here
        puts "I received a join message. Perhaps I should respond!"        
      else
        puts "Received join message: #{msg}"
      end      
    end
    
  end
end