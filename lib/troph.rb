$:.unshift(File.dirname(__FILE__) + "/troph")
require "core/hash"
require "core/string"

%w(types coder queue server handler caller).each do |lib|
  require "messaging/" + lib
end

module Troph
  def log(msg)
    DaemonKit.logger.debug msg
  end
  def self.queue_name(n=nil)
    if n
      @queue_name = n
    else
      @queue_name
    end
  end
end