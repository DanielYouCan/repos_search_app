# frozen_string_literal: true

module Validators
  class AbstractValidator
    attr_reader :errors

    def initialize(params)
      @errors = []

      params.each do |param, value|
        instance_variable_set("@#{param}".to_sym, value)
      end
    end

    class << self
      VALIDATION_TYPES = %i[presence inclusion size].freeze
      attr_reader :validation_rules

      def validate(attr_name, options)
        @validation_rules ||= []

        VALIDATION_TYPES.each do |type|
          @validation_rules << { name: attr_name, type: type, options: options[type], if: options[:if] } if options.key?(type)
        end
      end
    end

    def call
      validate!
      self
    rescue RuntimeError => e
      fail!(e)
    end

    def successful?
      errors.empty?
    end

    private

    def fail!(error)
      @errors << error.message
      self
    end

    def validate!
      validation_rules = self.class.validation_rules || []

      validation_rules.each do |valid_rule|
        variable = instance_variable_get("@#{valid_rule[:name]}")
        send valid_rule[:type], variable, valid_rule[:name], option: valid_rule[:options], statement: valid_rule[:if]
      end
    end

    def presence(variable, attribute, option: nil, statement:)
      return unless statement_truly?(statement)

      raise "#{attribute} field can not be blank" if variable.nil? || variable.empty?
    end

    def inclusion(variable, attribute, option:, statement:)
      return unless statement_truly?(statement)

      raise "#{attribute} field is not in permitted range" unless option.include?(variable)
    end

    def size(variable, attribute, option:, statement:)
      return unless statement_truly?(statement)

      field_to_check = variable.split(' ') if variable.is_a?(String)
      raise "#{attribute} field should contain #{option} elements" unless field_to_check.size == option
    end

    def statement_truly?(statement)
      return true unless statement
      return true if instance_variable_get("@#{statement[:attr]}").send(statement[:method], statement[:value])

      false
    end
  end
end
