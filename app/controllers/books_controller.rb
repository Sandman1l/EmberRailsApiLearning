# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]

  # GET /Books
  def index
    @books = Book.all
    json_response(@books)
  end

  # POST /Books
  def create
    @book = Book.create!(book_params)
    json_response(@book, :created)
  end

  # GET /Books/:id
  def show
    json_response(@book)
  end

  # PUT /Books/:id
  def update
    @book.update(book_params)
    head :no_content
  end

  # DELETE /Books/:id
  def destroy
    @book.destroy
    head :no_content
  end

  private

  def book_params
    # whitelist params
    params.permit(:title, :author_id, :price)
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
