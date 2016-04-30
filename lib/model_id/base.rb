module ModelId
  module Base
    def model_id
      @model_id
    end

    def initialize
      @model_id = self.class.last_model_id + 1
      self.class.last_model_id = @model_id
      super
    end

    def self.included(base)
      base.class_eval do
        class << self
          attr_accessor :last_model_id
        end
      end
      base.last_model_id = 0
    end
  end
end
