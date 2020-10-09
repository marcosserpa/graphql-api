module Mutations
  module Authors
    class DestroyAuthor < BaseMutation
      argument :id, ID, required: true

      # here we can just return a success - like a status, for example - just to respond that everything happened as we wanted
      field :success, Boolean, null: false

      def resolve(id:)
        author = ::Author.find_by(id: id)

        if author.books.destroy_all && author.destroy

          {
            success: true
          }
        else
          {
            success: false
          }
        end
      end
    end
  end
end