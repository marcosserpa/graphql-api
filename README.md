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