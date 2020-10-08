module Types
  class QueryType < Types::BaseObject
    field :authors, resolver: Queries::Authors
    field :books, resolver: Queries::Books
  end
end
