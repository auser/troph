module Troph
  class PresenceHandler < BaseHandler
    queue_name "presence"
    
    def handle_message msg
      puts "Received presence message: #{msg}"
    end
    
  end
end