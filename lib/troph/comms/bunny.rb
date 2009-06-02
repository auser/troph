module Troph
  class Bunny
        
    def fanout(msg)
      # create a fanout exchange
      exch = instance.exchange("troph_fan", :type => :fanout)
      
      Hive.queues.each do |qname|
        instance.queue(qname).bind(exch)
      end
      # publish a message to the exchange
      exch.publish(msg)
    end
    
    def send_to_queue(queue_name, msg, opts={})
      if srvs = opts.delete(:servers)
        srvs.each do |srv|
          i = instances[srv] ||= new.instance(:host => srv)
          exch = i.exchange(queue_name)
          publish(exch, msg, {:key => queue_name}.merge(opts))
        end
      else
        exch = instance.exchange(queue_name)
        publish(exch, msg, {:key => queue_name}.merge(opts))
      end
    end
        
    def fanout(msg)
      # create a fanout exchange
      exch = instance.exchange("troph_fan", :type => :fanout)
      
      Hive.queues.each do |qname|
        instance.queue(qname).bind(exch)
      end
      # publish a message to the exchange
      publish(exch, msg)
    end
    
    # publish the message after encrypting it and packing it
    def publish(exchange, msg, opts={})
      exchange.publish(Honey.package(msg), opts)
    end
    
    def setup_subscription(bee)
      queue = instance.queue(bee.queue_name)
      exch = instance.exchange(bee.queue_name)
      queue.bind(exch, :key => "#{bee.queue_name}")
      queue.subscribe(:consumer_tag => "#{bee.queue_name}_#{bee.identity}") do |data|
        msg = Honey.unwrap(data)
        bee.on_data(msg)
        queue.ack
      end
    end
    
    def instance(o={})
      return @instance if @instance      
      @instance = ::Bunny.new(o)
      @instance.start
      @instance
    end
    
  end
end