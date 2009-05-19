module Troph
  class Queue
    attr_reader :keyword, :bind, :opts
    
    def initialize(keyword, opts={}, &block)
      @keyword = keyword
      @opts = {}
      @bind = block if block
    end
    
    def apply(q)
      queue = MQ.queue(keyword)
      # queue.bind(keyword, @opts)
      queue.subscribe &bind
    end
    
  end
end