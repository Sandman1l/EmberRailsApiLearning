# frozen_string_literal: true

# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Bookstore API', type: :request do
  let!(:author) { create(:author) }
  let!(:publisher) {create(:publishing_house)}
  let!(:books) { create_list(:book, 10, price: 1.1, author_id: author.id, publisher_id: publisher.id) }
  let(:id) { author.id }
  # Test suite for GET /todos
  describe 'GET /authors' do
    # make HTTP get request before each example
    before { get '/authors' }

    it 'returns authors' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /authors/:id' do
    before { get "/authors/#{id}" }

    context 'when the record exists' do
      it 'returns the authors' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Author with 'id'=100/)
      end
    end
  end

  # Test suite for POST /authors
  describe 'POST /authors' do
    # valid payload
    let(:valid_attributes) { { name: 'Ayra'} }

    context 'when the request is valid' do
      before { post '/authors', params: valid_attributes }

      it 'creates a authors' do
        expect(json['name']).to eq('Ayra')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/authors', params: { } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /authors/:id' do
    let(:valid_attributes) { { name: 'Sigurd', author_id: id, discount: 1.1  } }

    context 'when the record exists' do
      before { put "/authors/#{id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /authors/:id' do
    before { delete "/authors/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
