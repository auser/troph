=begin rdoc
  Bee is the base worker in troph
  
  Usage:
    class Presence < Troph::Bee
      
      run_after 30 do
        # Do this after seconds
      end
      # When a bee gets handed a payload, this method, on_data
      # is called for the bee
      def on_data(payload)
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
    
    def self.event_loop(time, &block)
      run_after_blocks << [time, block]
    end
    
    def self.run_after_blocks
      @run_after_blocks ||= []
    end
    
    def queue_name
      @queue_name ||= self.class.to_s.downcase
    end
    
    def self.queue_name
      self.to_s.downcase
    end
    
    def self.private?
      @private_bee
    end
    
    def self.private_bee(n=false)
      @private_bee = n
    end
    
    def self.hive
      @hive ||= []
    end
    
    def self.inherited(receiver)
      hive << receiver unless hive.include?(receiver)
    end
    
    def setup_periodic_block
      self.class.run_after_blocks.each {|s, b| Thread.new {EM.run {EM.add_periodic_timer(s, &b)}} }
    end
    
    def setup_listener(comm_instance)
      queue = comm_instance.queue(queue_name)
      exch = comm_instance.exchange(queue_name)
      queue.bind(exch, :key => "#{queue_name}")
      queue.subscribe(:consumer_tag => "#{queue_name}_#{identity}") do |msg|
        queue.ack
        on_data(msg)
      end
    end
    
    # Idea taken so graciously from nanite
    def identity
      @identity ||= "%04x%04x%04x%04x%04x" % [rand(0x0001000),rand(0x0010000),rand(0x0000100),rand(0x1000000),rand(0x1000000)]
    end
    
  end
end