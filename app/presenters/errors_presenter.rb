# frozen_string_literal: true

module Presenters
  module ErrorsPresenter
    extend self

    def present!(errors)
      errors.join('. ')
    end
  end
end
