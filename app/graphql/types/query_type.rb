module Types
  class QueryType < Types::BaseObject
    field :authors, resolver: Queries::Authors
  end
end
