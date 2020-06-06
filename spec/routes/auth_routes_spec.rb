RSpec.describe AuthRoutes, type: :routes do
  describe 'POST /' do
    context 'valid auth token' do
      let(:user) { create(:user) }

      it 'returns corresponding user' do
        header 'Authorization', auth_token(user)
        post '/'

        expect(last_response.status).to eq(200)
        expect(response_body['meta']).to eq('user_id' => user.id)
      end
    end

    context 'invalid auth token' do
      it 'returns an error' do
        header 'Authorization', 'auth.token'
        post '/'

        expect(last_response.status).to eq(403)
      end
    end

    context 'missing auth token' do
      it 'returns an error' do
        post '/'

        expect(last_response.status).to eq(403)
      end
    end
  end
end
