module Troph
  class Comm
    attr_writer :testing
    
    def send_to_queue(queue_name, msg, opts={})
      raise_unimplemented_exception("send_to_queue(queue_name, msg, opts={})")
    end
        
    def fanout(msg)
      raise_unimplemented_exception("fanout(msg)")
    end
    
    def setup_subscription(bee)
      raise_unimplemented_exception("setup_subscription(bee)")
    end
    
    def teardown_subscription(bee)
      raise_unimplemented_exception("teardown_subscription(bee)")
    end
    
    private
    def raise_unimplemented_exception(msg)
      raise Exception.new("This communicator (#{self.class}) does not implement #{msg}")
    end
    
    def testing?
      testing == true
    end
                
  end
end

%w(bunny).each { |lib| require "comms/#{lib}" }