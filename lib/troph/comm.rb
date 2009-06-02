%w(bunny).each { |lib| require "comms/#{lib}" }

module Troph
  module Comm
    
    def send_to_queue(queue_name, msg, opts={})
      raise Exception.new("This communicator does not implement send_to_queue(queue_name, msg, opts={})")
    end
        
    def fanout(msg)
      raise Exception.new("This communicator does not implement fanout(msg)")
    end
    
    def setup_subscription(bee)
      raise Exception.new("This communicator does not implement setup_subscription(bee)")
    end
                
  end
end