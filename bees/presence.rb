class Presence < Troph::Bee
  
  run_after 30 do
    # Do this after seconds
    puts "me!"
  end
  # When a bee gets handed a payload, this method, on_data
  # is called for the bee
  def on_data(payload, queue_instance)
    # Do stuff with the payload
  end

end