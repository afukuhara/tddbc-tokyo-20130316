class LTSV
  def initialize
    @key_index = []
    @data = { }
  end

  def [](key)
    @data[key]
  end

  def []=(key,value)
    raise ArgumentError if key.nil?
    raise ArgumentError if key == ""

    @key_index.delete(key)
    @key_index.push(key)

    if @data.key?(key)
      before_update = @data[key]
      @data[key] = value
      before_update
    else
      @data[key] = value
    end
  end

  alias :set :[]=

  def dump
    @key_index.map { |ki| "#{ki}:#{@data[ki]}" }.join("\t")
  end
end
