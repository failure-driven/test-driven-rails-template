def source_paths
  Array(super) + [__dir__]
end

gem_group :development, :test do
  gem "capybara"
  gem "capybara-inline-screenshot"
  gem "rspec-example_steps"
  gem "rspec-rails"
  gem "site_prism"
  gem "webdrivers"
end

gem_group :development do
  gem "rubocop-capybara", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "standard", require: false
end

run "bundle install"

generate "rspec:install"

run "bundle binstubs rspec-core"

copy_file ".rubocop.yml", force: true
copy_file "spec/features/blog_crud_spec.rb"
copy_file "spec/support/capybara.rb"
copy_file "spec/support/pages/helpers/forms_helper.rb"
copy_file "spec/support/pages/blog_page.rb"
copy_file "spec/support/pages/it_works_root.rb"
copy_file "spec/support/force_api_error.rb"
copy_file "spec/support/pause_service.rb"
copy_file "Makefile"

# empty_directory "spec/features"

template "spec/features/it_works_spec.rb.tt"

gsub_file '.rspec', '--require spec_helper', '--require rails_helper'
inject_into_file ".rspec", after: "--require rails_helper\n" do
  <<~RUBY
    --format documentation
  RUBY
end

inject_into_file "spec/rails_helper.rb", after: "# require only the support files necessary.\n#\n" do
  <<~RUBY
    # loading helpers and sections ahead of other SitePrism pages that use them
    Rails.root.glob("spec/support/pages/helpers/**/*.rb").sort.each { |f| require f }
    Rails.root.glob("spec/support/pages/section/**/*.rb").sort.each { |f| require f }
    Rails.root.glob("spec/support/**/*.rb").sort_by(&:to_s).each { |f| require f }

  RUBY
end

inject_into_file "spec/rails_helper.rb", after: "# config.filter_gems_from_backtrace(\"gem name\")\n" do
  <<~RUBY
    # for pausing API requests and forcing API errors
    config.include PauseService, type: :feature
    config.include ForceApiError, type: :feature

    config.after(:each, type: :feature) do
      clear_api_error
      Rails.application.config.should_pause = nil
    end

    # render views for controller specs to render jbuilder templates
    config.render_views = true

    # as per https://github.com/railsware/rspec-example_steps/issues/14
    RSpec::Core::Formatters.register(
      RSpec::Core::Formatters::DocumentationFormatter,
      :example_group_started,
      :example_group_finished,
      :example_passed,
      :example_pending,
      :example_failed,
      :example_started,
      :example_step_passed,
      :example_step_pending,
      :example_step_failed
    )
  RUBY
end

inject_into_file(
  "config/routes.rb",
  after: "# Define your application routes per the DSL in" \
    " https://guides.rubyonrails.org/routing.html\n"
) do
  <<~RUBY
    if Rails.env.local?
      # a test only route used by spec/features/it_works_spec.rb
      get "test_root", to: "rails/welcome#index", as: "test_root_rails"
    end

  RUBY
end

run "make"
run "make lint-fix"
run "make build"
# after_bundle do
#   if yes?("Would you like to install React? (Y/n)")
#     rails_command "webpacker:install:react"
#   end
# end
