class Solitude < Troph::Bee
  
  # Does not get hit with a fanout
  private_bee true
  
  # When a bee gets handed a payload, this method, on_data
  def on_data(payload)
    # Do stuff with the payload
    Troph::Log.info "Quiet"
  end

end