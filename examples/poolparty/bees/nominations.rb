class Nominations < Troph::Bee
  
  event_loop 5 do
    # Do this after 30 seconds
    # Troph::Log.info "Nominations!"
  end
  
  # When a bee gets handed a payload, this method, on_data
  # is called for the bee
  def on_data(payload)
    # Do stuff with the payload
    Troph::Log.info "received nomination message: #{payload}"
  end

end