class Hash
  # Converts all of the keys to strings
  def symbolize_keys!
    keys.each{|k| 
      v = delete(k)
      self[k.to_sym] = v
      v.symbolize_keys! if v.is_a?(Hash)
      v.each{|p| p.symbolize_keys! if p.is_a?(Hash)} if v.is_a?(Array)
    }
    self
  end
end