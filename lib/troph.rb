$:.unshift(File.dirname(__FILE__) + "/troph")
require 'rubygems'
require 'eventmachine'
require 'amqp'
require 'mq'
require 'socket'

require "messaging/queue"
require "messaging/server"

require "p2p/types"
require "p2p/node_store"

module Troph
  class Base
    def self.server(name=nil,&block)
      Server.new name, &block
    end
  end
end