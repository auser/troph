module Troph
  class PresenceHandler < BaseHandler
    
    queue_name Troph::QUEUES[:presence]
    
    def handle_message(ty, msg)
      case ty.to_sym
      when :heartbeat
        # Do stuff here
        log "got heartbeat: #{server.fetch(:cloud).name}"
        
        server.nodes.each do |ip|
          log "Sending to #{ip}"
          begin
            Troph.send_to_queue(ip, :presence, :heartbeat, {:host => "#{server.host}"})
          rescue NoConnectionError => e
            puts "Remote #{ip} from responding nodes list"
          end          
        end
        
      else
        log "Received unhandled presence message: #{msg.inspect} (#{ty})"
      end
    end
    
  end
end