require "#{File.dirname(__FILE__)}/../test_helper"

class MatObj
  mattr_reader :sport, []
  mattr_accessor :equipment, {}
end

class ObjectTest < Test::Unit::TestCase
  context "mattr_accessor" do
    setup do
      @obj = MatObj.new
    end

    should "have sport as a method that defaults to an array" do
      assert @obj.respond_to?(:sport)
      assert_equal @obj.sport, []
    end
    
    should "have the reader, writer for equipment" do
      assert @obj.respond_to?(:equipment)
      assert @obj.respond_to?(:equipment=)
      assert_equal @obj.equipment, {}
    end
  end
  
end
