class Optional
  class Some
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

  class None
    def none?
      true
    end
  end

  def self.none
    None.new
  end

  def self.some(obj)
    Some.new(obj)
  end
end
