class Presence < Troph::Bee
  
  event_loop 3 do
    # Do this after 30 seconds
    # CloudGod.cloud.nodes(:status => "running")
    Troph::Comm.send_to_queue("presence", "Are you there?", :servers => ["127.0.0.1"])
  end
  
  # When a bee gets handed a payload, this method, on_data
  # is called for the bee
  def on_data(payload)
    # Do stuff with the payload
    Troph::Log.info "received presence message: #{payload}"
  end

end