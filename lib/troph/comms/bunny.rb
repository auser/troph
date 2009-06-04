module Troph
  class Bunny < Comm
    
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
      package = Package.new(opts.delete(:package))      
      package.payload = msg
      
      exchange.publish(package.dump, opts)
    end
    
    def setup_subscription(bee)
      queue, exch = queue_and_exchange(bee)
      queue.bind(exch, :key => "#{bee.queue_name}")
      
      opts = {:consumer_tag => consumer_tag(bee)}
      opts.merge!(:header => true) if bee.accepts_header?
      
      queue.subscribe(opts) do |data|
        package = Package.from_data(data)
        bee.on_data(package)
        queue.ack
      end
    end
    
    def teardown_subscription(bee)
      queue, exch = queue_and_exchange(bee)
      queue.bind(exch, :key => "#{bee.queue_name}")
      
      queue.unsubscribe({:consumer_tag => consumer_tag(bee)})
    end
    
    private
    
    def queue_and_exchange(bee)
      queue = instance.queue(bee.queue_name)
      exch = instance.exchange(bee.queue_name)
      [queue, exch]
    end
    
    def instance(o={})
      return @instance if @instance      
      @instance = ::Bunny.new(o)
      @instance.start
      @instance
    end
    
    def consumer_tag(bee)
      "#{bee.queue_name}_#{bee.identity}"
    end
    
  end
end