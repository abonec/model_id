module ModelId
  module Base
    def model_id
      @model_id
    end

    def set_next_model_id
      @model_id = self.class.last_model_id + 1
      self.class.last_model_id = @model_id
    end

    def self.included(base)
      if base.respond_to? :prepend
        base.prepend Ruby2Initializer
        base.class_eval do
          class << self
            attr_accessor :last_model_id
          end
        end
        base.last_model_id = 0
      end
    end

    module Ruby2Initializer
      def initialize(*args)
        set_next_model_id
        super(*args)
      end
    end
  end
end
