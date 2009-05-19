module Troph
  class Queue
    attr_reader :keyword, :bind, :opts, :queue
    
    def initialize(keyword, opts={}, &block)
      @keyword = keyword
      @opts = {}
      @bind = block if block
    end
    
    def apply(q)
      @queue = MQ.queue(keyword)
      @queue.subscribe &bind
    end
        
    def method_missing(m,*a,&block)
      if queue.respond_to?(m)
        queue.__send__ m, *a, &block
      else
        super
      end
    end
    
  end
end