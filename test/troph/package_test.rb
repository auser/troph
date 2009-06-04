require "#{File.dirname(__FILE__)}/../test_helper"

class PackageTest < Test::Unit::TestCase
  context "package" do
    should "have a token when created" do
      assert_not_nil Troph::Package.new.token
    end
    should "set each hash value on the package" do
      pack = Troph::Package.new(:action => "jackson")
      assert_equal "jackson", pack.action
    end
    should "dump as an object with .dump (packing the payload)" do
      pack = Troph::Package.new
      assert_equal Marshal.load(pack.dump).token, pack.token
    end
    should "load the object from a Marshal dump" do
      pack = Troph::Package.new(:action => "me")
      assert_equal Troph::Package.from_data(Marshal.dump(pack)).token, pack.token
    end
  end
end