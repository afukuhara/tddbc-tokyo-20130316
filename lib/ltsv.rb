class LTSV
  def initialize
    @data = { }
  end

  def [](key)
    @data[key]
  end

  def []=(key, value)
    raise ArgumentError if (key.nil? or key.empty?)

    before_update = @data.delete(key)
    @data[key] = value
    before_update
  end

  alias :set :[]=

  def dump
    @data.map { |k,v| "#{k}:#{v}" }.join("\t")
  end
end
