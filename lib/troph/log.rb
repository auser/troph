module Troph
  class Log
    LOG_LEVELS = [:debug, :info, :warn, :error, :fatal]
        
    class << self
      attr_reader :path, :log_name
      
      def init(name="bee.log", path = false)
        @path = path
        @log_name = name
        reset!
      end
      
      LOG_LEVELS.each do |level|
        define_method(level) {|*a| logger.send(level, *a) }
      end
      
      def pipe
        @pipe ||= path ? File.join(path, "#{@log_name}.log") : $stdout
      end
      
      def logger
        @logger ||= Logger.new(pipe)
      end
      
      def reset!
        @pipe = @logger = nil
      end
      
    end
    
  end
end