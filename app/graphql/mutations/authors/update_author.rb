module Mutations
  module Authors
    class UpdateAuthor < BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false

      field :author, Types::AuthorType, null: true

      def resolve(args)
        author = ::Author.find_by(id: args[:id])
        params = args.compact.except(:id)

        if author.update(args)
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