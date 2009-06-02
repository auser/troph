module Troph
  class Formatter < Logger::Formatter
    @@show_time = true
    
    def self.show_time=(show=false)
      @@show_time = show
    end
    
    # Prints a log message as '[time] severity: message'
    def call(severity, time, progname, msg)
      if @@show_time
        sprintf("[%s] %s: %s\n", time.to_s, severity, msg)
      else
        sprintf("%s: %s\n", severity, msg)
      end
    end
  end
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
        return @logger if @logger
        @logger = Logger.new(pipe)
        @logger.formatter = Formatter.new
        @logger
      end
      
      def reset!
        @pipe = @logger = nil
      end
      
    end
    
  end
end