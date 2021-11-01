class ReposController < ApplicationController
  get '/repos/search' do
    validator = search_validator.new(repos_params).call
    return render_with_errors(errors: validator.errors) unless validator.successful?

    service = repos_service.call(repos_params)
    return render_with_errors(errors: service.errors) unless service.successful?

    @repos = service.result
    erb :index
  end

  private

  def render_with_errors(errors:)
    erb :index, locals: { errors: errors_for_render(errors) }
  end

  def errors_for_render(errors)
    Presenters::ErrorsPresenter.present!(errors)
  end

  def search_validator
    @search_validator ||= Validators::SearchValidator
  end

  def repos_service
    @repos_service ||= Services::ReposService
  end

  def repos_params
    params.slice('value', 'field')
  end
end
