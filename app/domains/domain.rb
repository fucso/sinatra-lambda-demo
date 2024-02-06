require 'active_model'

module Domain
  def self.included(base)
    base.extend ClassMethods
  end

  @_initialize_converter = {}

  module ClassMethods
    def initialize_converter(**converter)
      @_initialize_converter = converter
    end

    def _initialize_converter
      @_initialize_converter || {}
    end
  end

  def initialize(**args)
    converter = self.class._initialize_converter
    args.each do |key, value|
      next unless self.respond_to?("#{key}=")
      if converter.key?(key)
        value = converter[key].call(value)
      end
      self.send("#{key}=", value)
    end
  end
end