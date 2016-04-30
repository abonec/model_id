require 'thread'
module ModelId
  module Base
    def model_id
      @model_id
    end

    def set_next_model_id
      self.class.model_id_mutex.synchronize do
        @model_id = self.class.last_model_id + 1
        self.class.last_model_id = @model_id
      end
      self.class.model_id_instances[@model_id] = self
    end

    def delete_model
      self.class.model_id_instances.delete @model_id
    end

    def self.included(base)
      base.class_eval do
        class << self
          attr_accessor :last_model_id, :model_id_mutex, :model_id_instances
        end
      end
      base.extend ClassMethods
      base.last_model_id = 0
      base.model_id_mutex = Mutex.new
      base.model_id_instances = {}
      base.prepend Ruby2Initializer if base.respond_to? :prepend
    end

    module ClassMethods
      def find_by_id(id)
        model_id_instances[id]
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
