class Optional
  def self.none
    None.new
  end

  def self.some(obj)
    Some.new(obj)
  end
end

class Some < Optional
  def initialize(obj)
    @obj = obj
  end

  def get
    @obj
  end

  def none?
    false
  end
end

class None < Optional
  def none?
    true
  end
end
