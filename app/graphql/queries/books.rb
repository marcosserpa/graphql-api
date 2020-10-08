module Queries
  class Books < BaseQuery
    type [Types::BookType], null: false

    def resolve
      books = ::Book.all
      books
    end
  end
end
