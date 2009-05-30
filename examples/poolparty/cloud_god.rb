# require "rubygems"
# begin
#   require "/Users/alerner/Development/ruby/mine/poolparty/lib/poolparty"
# rescue Exception => e
#   require "poolparty"
# end
# 
# begin  
#   require "/etc/poolparty/clouds.rb"
# rescue Exception => e
#   cloud :test_cloud do
#   end
# end

class CloudGod
  def self.cloud
    @cloud ||= clouds[cloud_name.to_sym]
  end
  def self.cloud_name
    @cloud_name ||= open("/etc/poolparty/cloudname").read rescue "test_cloud"
  end
end