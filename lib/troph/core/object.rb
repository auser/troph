class Object
  def self.mattr_reader(sym, default=[])
    define_method(sym) do
      eval "@#{sym} ||= #{default.class}.new"
    end
  end
  def self.mattr_accessor(sym, default=[])
    mattr_reader(sym, default)
    attr_writer sym
  end
end