$:.unshift(File.dirname(__FILE__) + "/troph")
require "core/hash"
require "core/string"

%w(types coder queue server handler caller).each do |lib|
  require "messaging/" + lib
end

module Troph
  class Base
    def self.server(name=nil,&block)
      Server.new name, &block
    end
  end
  def log(msg)
    DaemonKit.logger.debug msg
  end
end