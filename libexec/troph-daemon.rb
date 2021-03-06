# Generated amqp daemon

t=Time.now
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

Troph::Log.info "Loading custom hive"

require 'optparse'
OptionParser.new { |op|
  op.on('-c config', '--config config')   { |c| @c = c }
}.parse!(ARGV.dup)

raise StandardError.new("You must supply a hive (config) file with -c config_file") unless @c

require "#{File.dirname(__FILE__)}/../examples/poolparty/pool_party_hive.rb"

Troph::Log.info "Loaded = #{Time.now-t}"
# Run an event-loop for processing
DaemonKit::AMQP.run do
  # amq = ::MQ.new
  # amq.queue('test').subscribe do |msg|
  #   DaemonKit.logger.debug "Received message: #{msg.inspect}"
  # end
  PoolPartyHive.start(DAEMON_ROOT + "/" + File.dirname(@c))
end