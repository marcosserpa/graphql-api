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

#### GraphiQL gem installation

We will also use an awesome gem to use a browse-based IDE to test our GraphQL requests. So, add it to Gemfile:

```ruby
# Gemfile
...
group :development do
  gem 'graphiql-rails'
end
...
```

Install the gem:

```shell
bundle install
```

Now we need to tell Rails the route to that browse-based IDE. So, add the following to *routes.rb*:

```ruby
# config/routes.rb
...
if Rails.env.development?
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: 'graphql#execute'
end
...
```