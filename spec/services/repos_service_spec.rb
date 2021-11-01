describe Services::ReposService do
  describe '.call' do
    subject(:response) { described_class.call(params) }

    context 'with valid params' do
      let(:params) { { 'value' => 'ruby', 'field' => 'name' } }

      it 'is successful', :vcr do
        is_expected.to be_successful
      end
    end

    context 'with invalid params' do
      let(:params) { { 'value' => 'ruby', 'field' => 'owner' } }
      let(:external_error) do
        'The listed users and repositories cannot be searched either because the resources do not exist or you do not have permission to view them.'
      end

      it 'returns an error', :vcr do
        is_expected.not_to be_successful
        expect(subject.errors).to include(external_error)
      end
    end
  end
end
  