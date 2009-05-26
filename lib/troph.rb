$:.unshift(File.dirname(__FILE__) + "/troph")
require "rubygems"
require "json"

require "core/hash"
require "core/string"

%w(types coder queue server handler caller).each do |lib|
  require "messaging/" + lib
end

module Troph
  class Base
    def self.server(name, &block)
      Server.new(name, &block)
    end
  end
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