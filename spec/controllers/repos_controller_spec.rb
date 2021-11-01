describe ReposController do
  describe 'GET to /repos/search' do
    subject(:response) { get '/repos/search', **params }

    context 'with valid params' do
      let(:params) do
        { value: 'ruby', field: 'name' }
      end

      it 'returns 30 repos for request', :vcr do
        expect(response.body).to have_tag(:div, with: { class: 'col-2 repo-name' }, count: 30)
      end
    end

    context 'with invalid params' do
      let(:params) do
        { value: 'ruby', field: 'owner' }
      end
      let(:error_text) { 'value field should contain 2 elements' }

      it 'returns an error', :vcr do
        expect(response.body).to have_tag(:p, with: { class: 'errors' }, text: error_text)
      end
    end
  end
end
