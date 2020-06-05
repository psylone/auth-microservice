RSpec.describe UserRoutes, type: :routes do
  describe 'POST /' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/', name: 'bob', email: 'bob@example.com', password: ''

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        post '/', name: 'b.o.b', email: 'bob@example.com', password: 'givemeatoken'

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите имя, используя буквы, цифры или символ подчёркивания',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      it 'returns created status' do
        post '/', name: 'bob', email: 'bob@example.com', password: 'givemeatoken'

        expect(last_response.status).to eq(201)
      end
    end
  end
end
