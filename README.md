# TL;DR

```sh
# clone this repo
git clone git@github.com:failure-driven/test-driven-rails-template.git

# create a rails new project using the template
rails _8.0.2_ new rails8-demo \
    --database sqlite3 \
    --minimal \
    --skip-test \
    --skip-keeps \
    -m test-driven-rails-template/template.rb

# or with JS and CSS processing
rails _8.0.2_ new rails8-demo \
    --database sqlite3 \
    --skip-test \
    --skip-keeps \
    --no-skip-turbo \
    --no-skip-javascript \
    --javascript=importmap \
    -m test-driven-rails-template/template.rb

bin/rails importmap:install
bin/rails stimulus:install:importmap
```

# test-driven-rails-template

A Rails template to bootstrap test driven rails project. The template is in
particular focused on creating some initial example tests to help in setting up
a repo to be used in workshops.

## Usage

Basic useage

```sh
rails _6.0.0_ new signup-demo --database=postgresql --skip-test -m template.rb
# OR
rails _8.0.2_ new rails8-demo \
    --database sqlite3 \
    --minimal \
    --skip-test \
    --skip-keeps \
    -m template.rb
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

- some ideas for templates
    - https://github.com/mattbrictson/rails-template
    - BUT the author has moved onto their nextgem
    - https://github.com/mattbrictson/nextgen

- [ ] **feedback**
    - [x] rubocop_cache added to .gitignore
    - [x] how to make it work with javascript
        - [ ] and css processor?
    - [x] rubocop requires enabling
  ```ruby
  # config.infer_spec_type_from_file_location!
  ```
       seems like this is out of sync with rails_helper.rb which

       > but this behaviour is considered legacy and will be removed in a future version.

    - [x] `.tool-versions` for ASDF
- [ ] **minimal for BDD Workshop**
    - [x] db/structure.sql
    - [x] page fragments
    - [ ] Basic CSS - scss, basic styles
        - [ ] simple ability to add bulma and/or bootstrap
    - [x] Basic JS
    - [ ] View components for:
        - [x] Action button,
        - [ ] Form field with errors?
        - [ ] React component

[x] annotations
    - [x] controllers `chusaku`
    - [x] models `annotaterb`
[ ] erb-lint https://github.com/Shopify/erb_lint
    and https://github.com/Shopify/better-html#configuration
    ```sh
    bundle add erb_lint
    bundle exec erb_lint  --lint-all --autocorrect
    # hand generated an .erb_lint.yml file
    # probably need a .better-html.yml as well
    # but had a bunch of issues - need to read the docs more
    ```
[ ] make it work with `Dockerfile` via `--no-skip-docker`
    ```sh
    docker run --env RAILS_ENV=development -p 3000:3000 $(docker build -q .)
    ```
    above does not "name" the image and the port forward seems to not work
[ ] rubocop and erblint ? and binstubs?
    ```sh
    def run_rubocop_autocorrections
      run_with_clean_bundler_env "bin/rubocop -A --fail-level A > /dev/null || true"
      run_with_clean_bundler_env "bin/erblint --lint-all -a > /dev/null || true"
    end
    ```
[ ] example using the pause service and force api error?
    - have added a concern and buttons that change state in demo#show but did
      not manage the test to succeed?
[ ] deal with `.rubocop.yml` conflict (only rails 7 not rails 8)
[ ] handle `bundle install` when no internet
[ ] binstub for bin/dev - rails 7 only? seems ok in rails 8
[ ] Makefile vs Justfile
[ ] structure.sql over schema.rb
[ ] fix if there are old versions of gems installed and it breaks on trying to
    install rspec
[ ] pass parameters like --database and --skip-test directly in the template.rb
[ ] add files with some demo tests
[ ] make some of this setup more configurable
[ ] add a test build to make sure this template can still create a rails
    project based on various starting versions of Rails, Ruby and Node

### DONE

[x] rspec binstub
[x] add capybara setup
[x] test route
    ```ruby
    if Rails.env.test?
      # a test only route used by spec/features/it_works_spec.rb
      get "test_root", to: "rails/welcome#index", as: "test_root_rails"
    end
    ```
[x] .rspec `--include rails_helper`
[x] rubocop -A
[x] can you populate via it_works_spec.rb via ~~ERB~~ .tt
[x] see how good a "modify works" - seems OK
[x] rubocop setup
[x] make sure all example steps are displayed
    - as per https://github.com/railsware/rspec-example_steps/issues/14
    - is this new in rails 8 again?
