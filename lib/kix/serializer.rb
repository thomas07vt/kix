# frozen_string_literal: true

module Kix
  class Serializer
    attr_reader :_object

    def initialize(object)
      @_object = object
    end

    def as_json(*args)
      self.class.defined_attributes.each_with_object({}) { |attr, h|
        catch(:skip) { h[attr] = value_for(attr, args).as_json }
      }
    end

    private

    def value_for(attr, args)
      if respond_to?(attr)
        send(attr)
      else
        _object.send(attr)
      end
    end

    class << self
      def inherited(subclass)
        subclass.attributes(*@defined_attributes)
      end

      def attributes(*attrs)
        attrs.each { |attr| defined_attributes.push(attr.to_s) }
      end
      alias_method :attribute, :attributes

      def defined_attributes
        @defined_attributes ||= []
      end
    end
  end
end
