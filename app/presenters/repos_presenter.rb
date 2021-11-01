# frozen_string_literal: true

module Presenters
  class ReposPresenter
    attr_reader :owner_name, :owner_url, :repo_name, :repo_url, :description

    def initialize(params)
      @owner_name = params.dig('owner', 'login')
      @owner_url = params.dig('owner', 'html_url')
      @repo_name = params['name']
      @repo_url = params['html_url']
      @description = params['description']
    end
  end
end
