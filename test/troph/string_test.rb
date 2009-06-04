require "#{File.dirname(__FILE__)}/../test_helper"

class TrophTest < Test::Unit::TestCase
  context "string" do
    should "camelcase properly" do
      assert_equal "file_of_the_day".camelcase, "FileOfTheDay"
      assert_equal "no".camelcase, "No"
      assert_equal "no_way".camelcase, "NoWay"
    end
  end
  
end