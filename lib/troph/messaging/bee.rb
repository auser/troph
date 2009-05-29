=begin rdoc
  Bee is the base worker in troph
  
  Usage:
    class Presence < Troph::Bee
      
      run_after 30 do
        # Do this after seconds
      end
      # When a bee gets handed a payload, this method, on_data
      # is called for the bee
      def on_data(payload, queue_instance)
        # Do stuff with the payload
      end

    end
    
  The above class will listen on the "presence" (from the class name) 
  queue and listen for payloads. They can also run after a set amount of time.
  This is accomplished by passing periodic_run as a method in the class
=end
module Troph
  class Bee
    
    def on_data(payload)
      raise Exception.new("#{self.class} does not accept on_data(payload)")
    end
    
    def self.event_loop(&block)
      run_after_blocks << block
    end
    
    def self.run_after_blocks
      @run_after_blocks ||= []
    end
    
    def queue_name
      @queue_name ||= self.class.to_s.camelcase
    end
    
    def self.hive
      @hive ||= []
    end
    
    def self.inherited(receiver)
      hive << receiver unless hive.include?(receiver)
    end
    
    def periodic_block
      Proc.new do
        self.class.run_after_blocks.each {|s, b| EM.add_periodic_timer(s, &b)}
      end
    end
    
    def setup_listener(comm_instance)
      queue = comm_instance.queue(queue_name)
      exch = comm_instance.exchange(queue_name + "_exchange")
      queue.bind(exch, :key => "troph_#{queue_name}")
      queue.subscribe(:consumer_tag => queue_name) do |msg|
        comm_instance.ack
        on_data(msg)
      end
    end
    
  end
end