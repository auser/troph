# Generated amqp daemon

# Do your post daemonization configuration here
# At minimum you need just the first line (without the block), or a lot
# of strange things might start happening...
DaemonKit::Application.running! do |config|
  # Trap signals with blocks or procs
  # config.trap( 'INT' ) do
  #   # do something clever
  # end
  # config.trap( 'TERM', Proc.new { puts 'Going down' } )
end

require 'git-style-binary/command'

module GitStyleBinary
  def self.binary_directory
    "#{File.dirname(__FILE__)}/bin"
  end
end

unless $! || GitStyleBinary.run?
  command = GitStyleBinary::AutoRunner.run
  exit 0
end