class Announcement < Troph::Bee
  
  # When a bee gets handed a payload, this method, on_data
  def on_data(payload)
    # Do stuff with the payload
    Troph::Log.info "Announcements!"
  end

end