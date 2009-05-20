module Troph
  class PresenceHandler < BaseHandler
    
    queue_name Troph::QUEUES[:presence]
    
    def handle_message(ty, msg)
      case ty.to_sym
      when :heartbeat
        # Do stuff here
        server.nodes.each do |ip|
          puts "Sending to #{ip}"
          Troph.send_to_queue(ip, :presence, :heartbeat, {:host => "#{server.host}"})
        end
        
      else
        puts "Received presence message: #{msg.inspect} (#{ty})"
      end
    end
    
  end
end