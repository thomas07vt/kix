# frozen_string_literal: true

module Kix
  module Serializable
    extend ActiveSupport::Concern

    included do
      # This forces autoloading of the constant.
      serializer("#{self}Serializer".constantize)
    rescue NameError
    end

    class_methods do
      def inherited(klass)
        super
        klass.serializer(serializer)
      end

      def serializer(klass = nil)
        @serializer = klass if klass
        @serializer
      end
    end

    def as_json(*args)
      return super unless self.class.serializer

      self.class.serializer.new(self).as_json(*args)
    end
  end
end
