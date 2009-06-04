require "#{File.dirname(__FILE__)}/../test_helper"
Dir["#{::File.dirname(__FILE__)}/bees/*.rb"].each {|lib| require lib }

class UUIDTest < Test::Unit::TestCase
  context "generate" do
    should "generate a UUID with letters and numbers" do
      assert_match /[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]/, Troph::UUID.generate
    end
  end
  
end