module ModelId
  module Base
    def self.included(base)
      if base.respond_to? :prepend
        base.prepend InstanceMethods
        base.class_eval do
          class << self
            attr_accessor :last_model_id
          end
        end
        base.last_model_id = 0
      else
        raise 'ModelId supports only ruby 2.x now'
      end
    end

    module InstanceMethods
      def model_id
        @model_id
      end

      def initialize(*args)
        @model_id = self.class.last_model_id + 1
        self.class.last_model_id = @model_id
        super(*args)
      end

    end
  end
end
