A Mustache Sinatra Example
==========================

Get started:

    $ git clone http://github.com/defunkt/mustache-sinatra-example
    $ cd mustache-sinatra-example
    $ gem install bundler
    $ bundle install
    $ bundle exec shotgun -O config.ru

Or browser to <http://localhost:9393> by hand.

Note that we use a `templates` and a `views` directory. *You don't
have to.* By default the views and templates will live in the `views`
directory together.

We should:
  1) add a next button, spanning columns, tables, and eventually DBs
  2) add a "fields with same name" view and "same disposition" action
  3) consolidate filter logic across views into a single incantation

