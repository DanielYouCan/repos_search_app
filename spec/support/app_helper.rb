module AppHelper
  def app
    @app ||= Rack::Builder.new do
      use Rack::VCR
      run App
    end
  end
end
