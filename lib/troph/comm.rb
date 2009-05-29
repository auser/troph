%w(bunny).each { |lib| require "comms/#{lib}" }

module Troph
  class Comm
    
    def self.send_to_queue(queue_name, msg, opts={})
      if opts[:servers]
        opts[:servers].each do |srv|
          Troph::Log.info "Connect to #{srv} and send #{msg}"
        end
      else
        exch = instance.exchange(queue_name)
        exch.publish(msg, {:key => queue_name}.merge(opts))
      end
    end
        
    def self.fanout(msg)
      # create a fanout exchange
      exch = instance.exchange("troph_fan", :type => :fanout)
      
      Hive.queues.each do |qname|
        instance.queue(qname).bind(exch)
      end
      # publish a message to the exchange
      exch.publish(msg)
    end
        
    def self.instance
      @instance ||= new.instance
    end
    
    def instance
      Troph::BunnyComm.new.instance
    end
        
  end
end