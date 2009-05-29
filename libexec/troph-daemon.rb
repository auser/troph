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

require "#{File.dirname(__FILE__)}/../examples/poolparty/pool_party_hive.rb"

# Run an event-loop for processing
DaemonKit::AMQP.run do
  # amq = ::MQ.new
  # amq.queue('test').subscribe do |msg|
  #   DaemonKit.logger.debug "Received message: #{msg.inspect}"
  # end
  Troph::Log.info "Starting to run AMQP"
  PoolPartyHive.start
end