module Troph
  class Server
    include Troph
    
    attr_reader :topic, 
                :server_block, 
                :runtime_blocks,
                :listeners
    
    attr_writer :host
    attr_accessor :queues
    
    def initialize(t=nil, &block)
      @topic = t
      @runtime_blocks = []
      @queues = []
      @announce_presence = false
      instance_eval &block if block
    end
        
    def run      
      # Run an event-loop for processing
      DaemonKit::AMQP.run do
        if @announce_presence
          Troph.send_to_queue(host, :presence, :heartbeat, {:host => "#{host}"})
        end
        queues.each {|q| q.apply(s) }
        instance_eval &server_block if server_block
        
        runtime_blocks.each {|blk| instance_eval &blk }        
      end
    end
    
    def at_run &block
      @server_block = block
    end
    
    # If we want to announce our presence to the presence queue when
    # we start, provide the host
    def announce_presence
      @announce_presence = true
    end
    
    def host
      @host ||= "127.0.0.1"
    end
    
    def get_nodes_method(n=nil, &block)
      if block
        @get_nodes_method = block
      else
        if n.nil?
          @get_nodes_method
        else
          @get_nodes_method ||= n
        end
      end
    end
    
    def nodes
      # if respond_to?(:stored?) && stored?(:nodes)
      #   fetch(:nodes)
      if @get_nodes_method
        case @get_nodes_method
        when Proc
          @get_nodes_method.call
        else
          eval "#{@get_nodes_method}"
        end        
      else
        []
      end
    end
    
    # Storage!
    def store(k,obj)
      runtime_blocks << proc{
        __store[k] = obj
        MQ.new.rpc("storage", __store)
        log "Stored"
      }
    end
    
    def fetch(k)
      __store[k]
    end
    
    private
    
    def add_message_handler(klass, &block)
      queue(klass.queue_name) do |headers, msg|
        klass.send :new, Troph.receive_message(msg).merge(:headers => headers).symbolize_keys!, self, &block
      end
    end
    
    def add_runtime_caller(klass, seconds=1)
      runtime_blocks << proc {
        EM.add_periodic_timer(seconds) do
          klass.send :new, self
        end
      }
    end
    
    def queue(t, o={}, &block)
      if block
        @queues << Queue.new(t, o, &block)
      end      
    end
    
    def server_opts
      {:host => host}
    end
    
    def __store
      @__store ||= {}
    end
    
  end
end