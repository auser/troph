class String
  ##
  # @param o<String> The path component to join with the string.
  #
  # @return <String> The original path concatenated with o.
  #
  # @example
  #   "merb"/"core_ext" #=> "merb/core_ext"
  def /(o)
    File.join(self, o.to_s)
  end
  
  # Camelcase a string
  def camelcase
    gsub(/(^|_|-)(.)/) { $2.upcase }
  end
  
  # Constantize tries to find a declared constant with the name specified
  # in the string. It raises a NameError when the name is not in CamelCase
  # or is not initialized.
  #
  # Examples
  #   "Module".constantize #=> Module
  #   "Class".constantize #=> Class
  def constantize(mod=Object)
    camelcased_word = camelcase
    mod.module_eval(camelcased_word, __FILE__, __LINE__)
  end
  
  # "FooBar".snake_case #=> "foo_bar"
   def snake_case
     gsub(/\B[A-Z]+/, '_\&').downcase
   end
  
end