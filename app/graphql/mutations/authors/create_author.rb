module Mutations
  module Authors
    class CreateAuthor < BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true

      field :author, Types::AuthorType, null: true

      def resolve(name:, email:)
        author = ::Author.new(
          name: name,
          email: email
        )

        if author.save
          {
            author: author
          }
        else
          {
            errors: author.errors
          }
        end
      end
    end
  end
end