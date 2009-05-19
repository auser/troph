module Troph
  class Server
    attr_reader :topic, 
                :host, 
                :server_block, 
                :runtime_blocks,
                :listeners
    
    attr_accessor :queues
    
    def initialize(t=nil, &block)
      @topic = t
      @runtime_blocks = []
      @queues = []
      @announce_presence = false
      instance_eval &block if block
      $server = self      
    end
        
    def run      
      # TODO: Do a nice api, 'cause you can
      AMQP.start(server_opts) do |s|
        if @announce_presence
          q = MQ.queue(Troph::QUEUES[:presence])
          q.publish("Alive\t#{host}")
        end
        queues.each {|q| q.apply(s) }
        instance_eval &server_block if server_block
        
        runtime_blocks.each {|blk| instance_eval &blk }
      end
    end
    
    def at_run &block
      @server_block = block
    end
    
    private
    
    def add_message_handler(klass)
      queue(klass.queue_name) do |msg|
        klass.send :new, msg
      end
    end
    
    def add_runtime_caller(klass, seconds=1)
      runtime_blocks << proc {
        EM.add_periodic_timer(seconds) do
          klass.send :new
        end
      }
    end
    
    
    def server_opts
      {:host => host}
    end
    
    # If we want to announce our presence to the presence queue when
    # we start, provide the host
    def announce_presence(host="127.0.0.1")
      @announce_presence = true
      @host = host
    end
    
    def host
      @host ||= "127.0.0.1"
    end
    
    def queue(t, o={}, &block)
      if block
        @queues << Queue.new(t, o, &block)
      end      
    end
    
    at_exit do
      if $! || $server.nil?
        exit
      end
      puts "Running server..."
      $server.run
    end
        
  end
end