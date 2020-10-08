Creating an API with Rails 6 (only API) and GraphQL
===

On the last project I worked, I faced some cool challenges that gave me the opportunity to study something new to me, that moment: GraphQL. Although I have focused and learned a very specific implementation/application (in Rails using the [graphql-ruby gem](https://graphql-ruby.org/)), still I learned much of the concepts and structure of GraphQL in general. Was amazing.

So, now I will create a simple Rails API application using GraphQL to try to share some concepts of what I learned and a general view if how I used this. :)

For this app I'll use:

* [Ruby 2.6.6](https://cache.ruby-lang.org/pub/ruby/2.6.6/ruby-2.6.6.zip)
* [Rails 6.0.3.2](https://weblog.rubyonrails.org/2020/6/17/Rails-6-0-3-2-has-been-released/)
* [GraphQL Ruby 1.11.5](https://github.com/rmosolgo/graphql-ruby/tree/v1.11.5)

So, basically our task will be build a simple GraphQL API with Rails. So, let's go.

Configurations
===

#### Building Rails application

As we want something very clean and simple, let's create something removing a lot of stuff we will not use in this app. So, after installing the Ruby and Rails versions mentioned above, to create the app, we would just run

```shell
rails new graphql-api --skip-yarn --skip-action-mailer --skip-action-cable --skip-coffee -T --api
```

Add 'graphql' gem to Gemfile:

```ruby
# Gemfile
...
gem 'graphql'
...
```
Now, install the gem:

```shell
bundle install
```

We will use SQlite for database, so nothing about settings has to be done here, related to that; just create the database:

```shell
bundle exec rails db:create
```

Models and Data
===

#### Building our models

Let's create now our models. The purpose is just show some basic functionalities of GraphQL queries and mutations. So, this will be a simple author-books application.

Let's create our authors model and it's database migration:

```ruby
bundle exec rails generate model Author email:string name:string
```

Now let's create our books model and it's database migration:

```ruby
bundle exec rails generate model Book title:string author:belongs_to description:text
```

Now, let's run our migrations:

```
bundle exec rails db:migrate
```

We cannot forget to add the `has_many` relationship from author to books:

```ruby
# app/models/author.rb
...
has_many :books
...
```

Let's also create some seeds:

```ruby
# db/seeds.rb
...
arthur = Author.create(name: 'Arthur Conan Doyle', email: 'contact@arthurconandoyle.com')
tolkien = Author.create(name: 'J. R. R. Tolkien', email: 'contact@tolkienbooks.com')

lost_world_descripion = "The Lost World is a science fiction novel by British writer Arthur Conan Doyle, published in 1912, concerning an expedition to a plateau in the Amazon basin of South America where prehistoric animals still survive"

silmarillion_description = "The Silmarillion, along with many of J. R. R. Tolkien's other works, forms an extensive though incomplete narrative of Eä, a fictional universe that includes the Blessed Realm of Valinor, the once-great region of Beleriand, the sunken island of Númenor, and the continent of Middle-earth, where Tolkien's most popular works—The Hobbit and The Lord of the Rings—take place."

Book.create(title: 'The Lost World', description: lost_world_descripion, isbn: 1234567, author: arthur)
Book.create(title: 'The Silmarillion', description: silmarillion_description, isbn: 7654321, author: tolkien)
...
```

Then run the seeds:

```shell
bundle exec rake db:seed
```

GraphQL
===

#### GraphQL gem installation

To install the gem, run

```shell
rails generate graphql:install
```

This will generates some files related to GraphQL basic configurations.

#### Postman over GraphiQL gem to testing (not used)

As we decided to create a Rails API application, without assets, we will use [Postman](https://www.postman.com/) to make the POST requests to the Rails server. But you should also try in some opportunity using GraphiQL ql gem.
It's an awesome gem to use a browse-based IDE to test GraphQL requests.

#### Objects generation

Now we can generate the GraphQL objects that will match our models book and author:

```shell
bundle exec rails generate graphql:object author
bundle exec rails generate graphql:object book
```

This will create the following 2 files:

*app/graphql/types/author_type.rb*
*app/graphql/types/book_type.rb*

#### Querying

To create the queries we will not just use the *query_type.rb* file. IMO, it blows up too much the file and leave things messed and confuse. So, we will use [Resolvers](https://graphql-ruby.org/fields/resolvers.html).

So, let's change our *query_type.rb* file. It should look like something like this:

```ruby
module Types
  class QueryType < Types::BaseObject
    ...
    field :authors, resolver: Queries::Authors
    ...
  end
end
```

Let's extend the *BaseQuery* class. Create a *base_query.rb* file inside **queries** folder:

```ruby
# app/graphql/queries/base_query.rb
module Queries
  class BaseQuery < GraphQL::Schema::Resolver
  end
end
```

Now, create the ***queries*** directory and, inside that, create the *authors.rb* file. that will have the following content:

```ruby
module Queries
  class Authors < BaseQuery
    type [Types::AuthorType], null: false

    def resolve
      authors = ::Author.all
      authors
    end
  end
end
```

#### Testing

Now let's test what we've done so far. Run the application:

```shell
bundle exec rails server
```

So, on your browser, on Postman, let's try this query - to get all existent authors and some informations (*id*, *name* and *email*):

```
query {
  authors {
    id
    name
    email
  }
}
```

If you did everything right so far, you should receive this response (on Postman response body):

```
{
  "data": {
    "authors": [
      {
        "id": "1",
        "name": "Arthur Conan Doyle",
        "email": "contact@arthurconandoyle.com"
      },
      {
        "id": "2",
        "name": "J. R. R. Tolkien",
        "email": "contact@tolkienbooks.com"
      }
    ]
  }
}
```