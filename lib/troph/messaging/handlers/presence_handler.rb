module Troph
  class PresenceHandler < BaseHandler
    
    queue_name Troph::QUEUES[:presence]
    
    def handle_message(ty, msg)
      case ty.to_sym
      when :heartbeat
        # Do stuff here
        puts "got heartbeat: #{server.fetch(:cloud).name}"
        
        server.nodes.each do |ip|
          puts "Sending to #{ip}"
          begin
            Troph.send_to_queue(ip, :presence, :heartbeat, {:host => "#{server.host}"})
          rescue NoConnectionError => e
            puts "Remote #{ip} from responding nodes list"
          end          
        end
        
      else
        puts "Received presence message: #{msg.inspect} (#{ty})"
      end
    end
    
  end
end