module Troph
  class BunnyComm
    
    def send_to_queue(queue_name, msg, opts={})
      exch = instance.exchange(queue_name)
      exch.publish(msg, {:key => queue_name}.merge(opts))
    end
        
    def fanout(msg)
      # create a fanout exchange
      exch = instance.exchange("troph_fan", :type => :fanout)
      
      Hive.queues.each do |qname|
        instance.queue(qname).bind(exch)
      end
      # publish a message to the exchange
      exch.publish(msg)
    end
    
    def instance(o={})
      b = ::Bunny.new({:logging => true}.merge(o))
      b.start
      b
    end
    
  end
end