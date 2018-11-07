class Optional
  attr_reader :obj

  def self.failure(obj, msg)
    Failure.new(obj, msg)
  end

  def self.success(obj)
    Success.new(obj)
  end
end

class Success < Optional
  def initialize(obj)
    @obj = obj
  end

  def success?
    true
  end
end

class Failure < Optional
  attr_reader :msg

  def initialize(obj, msg)
    @obj = obj
    @msg = msg
  end

  def success?
    false
  end
end
