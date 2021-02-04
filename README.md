# test-driven-rails-template

A Rails template to bootstrap test driven rails project. The template is in
particular focused on creating some initial example tests to help in setting up
a repo to be used in workshops.

## Usage

Basic useage

```sh
rails _6.0.0_ new signup-demo --database=postgresql --skip-test -m template.rb
```

Full useage

```sh
# create a new rails project
rails _6.0.0_ new signup-demo --database=postgresql \
    --skip-test -m template.rb

# optional UUID setup with PostgreSQL to use UUID no by default but
# if your PostgreSQL is setup to work with it probably better to use
# it.
Would you like to setup PostgreSQL with UUID? (y/N)

# during in stall when asked the following press enter to take Yes
# option.
Would you like to install React? (Y/n)
Would you like to install User setup? (Y/n)
Would you like to install Paste bin demo? (Y/n)

# INSTALL COMPLETE

# run the acceptance tests for seeing your Rails/React setup
bundle exec rspec spec/features/you_re_on_rails_and_react_spec.rb

# run the acceptance tests for user signup and login
bundle exec rspec spec/features/user_signup_and_login_spec.rb

# run the acceptance tests for paste bin demo
bundle exec rspec spec/features/paste_bin_demo_spec.rb

# run a full build of tests including rubocop and linting
make full_build
# or
bin/full_build

# run a CI build using docker
make ci_build

# run in development
rails server
bin/webpack-dev-server

# test using circle CI
... TODO

# production deploy to Heroku (assuming heroku installed and setup)
... TODO confirm
heroku create
heroku apps:rename signup-demo-omniauth
heroku buildpacks:add heroku/nodejs --index 1
heroku buildpacks:add heroku/ruby --index 2
git push heroku master
heroku run rake db:migrate
```

## TODO

[ ] fix if there are old versions of gems installed and it breaks on trying to
    install rspec
[ ] pass parameters like --database and --skip-test directly in the template.rb
[ ] add files with some demo tests
[ ] add capybara setup
[ ] make some of this setup more configurable
[ ] add a test build to make sure this template can still create a rails
    project based on various starting versions of Rails, Ruby and Node

