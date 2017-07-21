module Result
  class Success
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def success?
      true
    end

    def on_success
      yield(data)
      self
    end

    def on_failure
      self
    end
  end

  class Failure
    attr_reader :message, :data

    def initialize(error_message, data)
      @message = error_message
      @data = data
    end

    def success?
      false
    end

    def on_success
      self
    end

    def on_failure
      yield(message, data)
      self
    end
  end
end
