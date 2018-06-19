# frozen_string_literal: true

# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Bookstore API', type: :request do
  # initialize test data
  let!(:publishers) { create_list(:publishing_house, 10)}
  let(:id) { publishers.first.id }
  # Test suite for GET /todos
  describe 'GET /publishing_houses' do
    # make HTTP get request before each example
    before { get '/publishing_houses' }

    it 'returns publishing houses' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /publishing_houses/:id' do
    before { get "/publishing_houses/#{id}" }

    context 'when the record exists' do
      it 'returns the publishing houses' do
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
        expect(response.body).to match(/Couldn't find PublishingHouse with 'id'=100/)
      end
    end
  end

  # Test suite for POST /publishing_houses
  describe 'POST /publishing_houses' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm'} }

    context 'when the request is valid' do
      before { post '/publishing_houses', params: valid_attributes }

      it 'creates a publishing houses' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/publishing_houses', params: { } }

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
  describe 'PUT /publishing_houses/:id' do
    let(:valid_attributes) { { name: 'Pedo Bear Incorporated', publisher_id: id, discount: 1.1  } }

    context 'when the record exists' do
      before { put "/publishing_houses/#{id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /publishing_houses/:id' do
    before { delete "/publishing_houses/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
