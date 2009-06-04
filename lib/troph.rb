$:.unshift(File.dirname(__FILE__) + "/troph")
require "rubygems"
require "json"
require 'bunny'
require "logger"
require "eventmachine" # Only used for clock requirements

%w(object hash string).each do |lib|
  require "core/#{lib}"
end

require "log"
require "comm"

%w(uuid bee honey hive package).each do |lib|
  require "messaging/" + lib
end

module Troph
  def self.testing=(bool=false)
    @testing = bool
  end
  def self.testing
    @testing ||= false
  end
  def self.testing?
    @testing
  end
end