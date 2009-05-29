class AddressBook < Troph::Bee
  
  # Does not get hit with a fanout
  private_bee true
  
  # When a bee gets handed a payload, this method, on_data
  def on_data(payload)
    # Do stuff with the payload
    Troph::Log.info "Address book was hit, time to send it out to everyone I know with #{payload}"
  end

end