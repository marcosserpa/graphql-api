module Mutations
  module Books
    class CreateBook < BaseMutation
      # arguments needed to create a book
      argument :author_id, ID, required: true
      argument :title, String, required: true
      argument :description, String, required: true

      # type of the return to the call
      field :book, Types::BookType, null: true

      def resolve(title:, description:, author_id:)
        author = ::Author.find_by(id: author_id)
        book = author.books.build(
          title: title,
          description: description
        )

        # here we mount the structure of the JSON that will be returned
        if book.save
          {
            book: book
          }
        else
          {
            errors: book.errors
          }
        end
      end
    end
  end
end