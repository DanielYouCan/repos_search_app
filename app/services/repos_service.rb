# frozen_string_literal: true

require 'net/http'
require 'oj'

module Services
  class ReposService
    prepend BaseService
    attr_reader :value, :field, :result

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @value = params['value']
      @field = params['field']
    end

    def call
      uri = URI(build_query)
      res = Net::HTTP.get_response(uri)

      if res.is_a?(Net::HTTPSuccess)
        @result = process_response(res.body)
      else
        fail!(process_errors(res.body))
      end
    end

    def build_query
      return api_url.dup << "repo:#{@value.split[0]}/#{@value.split[1]}" if @field == 'owner'

      api_url.dup << "#{value} in:#{field}"
    end

    def api_url
      'https://api.github.com/search/repositories?q=is:public '
    end

    def process_response(body)
      process(body, 'items') { |item| repos_presenter.new(item) }
    end

    def process_errors(body)
      errors = process(body, 'errors') { |error| error['message'] }
      errors_presenter.present! errors
    end

    def process(body, type, &block)
      Oj.load(body)[type].map(&block)
    end

    def repos_presenter
      @repos_presenter ||= ::Presenters::ReposPresenter
    end

    def errors_presenter
      @errors_presenter ||= ::Presenters::ErrorsPresenter
    end
  end
end
