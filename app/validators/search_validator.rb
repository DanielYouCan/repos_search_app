# frozen_string_literal: true

module Validators
  class SearchValidator < AbstractValidator
    PERMITTED_FIELDS = %w[name description readme owner].freeze

    validate :value, presence: true
    validate :field, presence: true
    validate :field, inclusion: PERMITTED_FIELDS
    validate :value, size: 2, if: { attr: :field, method: :==, value: 'owner' }
  end
end
