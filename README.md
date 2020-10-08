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
rails new graphql-api --skip-yarn --skip-action-mailer --skip-action-cable --skip-sprockets --skip-coffee --skip-javascript --skip-turbolinks -T --api
```

Add 'graphql' gem to Gemfile:

```ruby
# Gemfile
...
gem 'graphql'
...
```