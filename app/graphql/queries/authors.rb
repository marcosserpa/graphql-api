module Queries
  class Authors < BaseQuery
    type [Types::AuthorType], null: false

    def resolve
      authors = ::Author.all
      authors
    end
  end
end
