require 'rails_helper'

  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token

    {
      'Authorization': "Bearer #{token}"
    }
  end

RSpec.describe "Houses", type: :request do
  let!(:user) { create(:user) }
  let!(:houses) { create_list(:house, 10, user_id: user.id) }
  let(:user_id) { user.id }
  let(:house_id) { houses.first.id }


  describe 'GET /api/houses' do
    before { get '/api/houses'}

    it 'returns houses' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/:id' do
    before { get "/api/houses/#{house_id}" }

    context 'when record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(house_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:house_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find House/)
      end
    end
  end

  describe 'POST /api/houses' do
    let(:valid_attributes) do
      { name: 'Apartment 1', description: 'Beatiful appartment', price: 500.00 }
    end

    context 'when the request is valid' do
      before { post '/api/houses', params: valid_attributes, headers: authenticated_header(user) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/houses', params: { name: 'Appartment 2' }, headers: authenticated_header(user) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/houses/:id' do
    let(:valid_attributes) { { name: 'House 2' } }

    context 'when the record exists' do
      before { put "/api/houses/#{house_id}", params: valid_attributes}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /api/houses/:id' do
    before { delete "/api/houses/#{house_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
