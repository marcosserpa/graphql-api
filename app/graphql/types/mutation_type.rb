module Types
  class MutationType < Types::BaseObject
    # Authors
    field :create_author, mutation: Mutations::Authors::CreateAuthor
    field :update_author, mutation: Mutations::Authors::UpdateAuthor
    field :destroy_author, mutation: Mutations::Authors::DestroyAuthor

    # Books
    field :create_book, mutation: Mutations::Books::CreateBook
  end
end
