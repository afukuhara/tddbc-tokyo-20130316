class LTSV
  ESCAPE = {
    "\r" => '\r',
    "\n" => '\n',
    ":"  => '\:',
    "\t" => '\t',
  }

  def initialize
    @data = { }
  end

  def [](key)
    @data[key]
  end

  def []=(key, value)
    raise ArgumentError if (key.nil? or key.empty? or value.nil?)

    escaped_key = escape(key)
    escaped_val = escape(value)

    before_update = @data.delete(escaped_key)
    @data[escaped_key] = escaped_val
    before_update
  end

  alias :set :[]=

  def dump
    @data.map { |k,v| "#{k}:#{v}" }.join("\t") + "\n"
  end

  private
  def escape(val)
    new_str = val
    ESCAPE.each do |k, v|
      new_str.gsub!(k, v)
    end

    new_str
  end
end
