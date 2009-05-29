%w(bunny).each { |lib| require "comms/#{lib}" }

module Troph
  class Comm
    
    def self.send_to_queue(queue_name, msg, opts={})
      if srvs = opts.delete(:servers)
        srvs.each do |srv|
          i = new.instance(:host => srv)
          exch = i.exchange(queue_name)
          exch.publish(msg, {:key => queue_name}.merge(opts))
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
        
    def self.instance(o={})
      @instance ||= new.instance(o)
    end
    
    def instance(o={})
      Troph::BunnyComm.new.instance(o)
    end
    
    # def self.method_missing(m,*a,&block)
    #   instance.send m,*a,&block
    # end
        
  end
end