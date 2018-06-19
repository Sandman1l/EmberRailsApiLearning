# frozen_string_literal: true

class Author < ApplicationRecord
   has_many :books, dependent: :destroy
   validates_presence_of :name
end
