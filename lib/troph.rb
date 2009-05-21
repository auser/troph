$:.unshift(File.dirname(__FILE__) + "/troph")
require 'rubygems'
require 'eventmachine'
require 'amqp'
require "json"
require 'mq'
require 'socket'

require "core/hash"

require "messaging/types"
require "messaging/coder"
require "messaging/queue"
require "messaging/server"
require "messaging/handler"
require "messaging/caller"

module Troph
  class Base
    def self.server(name=nil,&block)
      Server.new name, &block
    end
  end
end