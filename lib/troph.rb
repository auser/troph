$:.unshift(File.dirname(__FILE__) + "/troph")
require "rubygems"
require "json"

%w(object hash string).each do |lib|
  require "core/#{lib}"
end

require "log"

%w(bee packager hive).each do |lib|
  require "messaging/" + lib
end

module Troph
  def self.run?
    @run ||= true
  end
  def self.run=(bool=true)
    @run = bool
  end
end

at_exit do
  raise $! if $!
  Troph::Hive.run if Troph.run?
end