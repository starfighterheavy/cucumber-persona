require "cucumber/persona/version"

module Cucumber
  module Persona
    def self.find(name)
      @personas ||= []
      @personas[name] || (raise "No persona found for #{name}")
    end

    def self.define(name, &block)
      @personas ||= {}
      @personas[name] = BasePersona.new(name, &block)
    end

    def self.create_all
      @personas.each { |name, persona| persona.create }
    end

    class BasePersona
      def initialize(name, &block)
        @name = name
        @create_block = block
      end

      def create
        @create_block.call
      end
    end
  end
end
