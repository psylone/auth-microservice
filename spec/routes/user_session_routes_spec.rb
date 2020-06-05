RSpec.describe UserSessionRoutes, type: :routes do
  describe 'POST /' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/', email: 'bob@example.com', password: ''

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        post '/', email: 'bob@example.com', password: 'invalid'

        expect(last_response.status).to eq(401)
        expect(response_body['errors']).to include('detail' => 'Сессия не может быть создана')
      end
    end

    context 'valid parameters' do
      let(:token) { 'jwt_token' }

      before do
        create(:user, email: 'bob@example.com', password: 'givemeatoken')

        allow(JWT).to receive(:encode).and_return(token)
      end

      it 'returns created status' do
        post '/', email: 'bob@example.com', password: 'givemeatoken'

        expect(last_response.status).to eq(201)
        expect(response_body['meta']).to eq('token' => token)
      end
    end
  end
end
