# frozen_string_literal: true

# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Bookstore API', type: :request do
  # initialize test data
  let!(:author) { create(:author) }
  let!(:publisher) {create(:publishing_house)}
  let!(:books) { create_list(:book, 10, price: 1.1, author_id: author.id, publisher_id: publisher.id) }
  let(:author_id){author.id}
  let(:publisher_id) {publisher.id}
  let(:id) { books.first.id }
  # Test suite for GET /todos
  describe 'GET /books' do
    # make HTTP get request before each example
    before { get '/books' }

    it 'returns books' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /books/:id' do
    before { get "/books/#{id}" }

    context 'when the record exists' do
      it 'returns the book' do
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
        expect(response.body).to match(/Couldn't find Book with 'id'=100/)
      end
    end
  end

  # Test suite for POST /books
  describe 'POST /books' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', author_id: '1', price: 1.1 } }

    context 'when the request is valid' do
      before { post '/books', params: valid_attributes }

      it 'creates a book' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/books', params: { title: 'Foobar', price: 1.1 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Author must exist/)
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /books/:id' do
    let(:valid_attributes) { { title: 'Shopping', author_id: author.id,price: 1.1  } }

    context 'when the record exists' do
      before { put "/books/#{id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /books/:id' do
    before { delete "/books/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
