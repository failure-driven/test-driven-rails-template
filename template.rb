def source_paths
  Array(super) + [File.expand_path(File.dirname(__FILE__))]
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-example_steps'
  gem 'capybara', '>= 3.14'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 3.0'
  gem 'rspec-wait'

  gem 'pry-rails'
end

generate "rspec:install"
copy_file "spec/support/capybara.rb"
copy_file "spec/support/features/page_fragments.rb"
copy_file "spec/support/force_api_error.rb"
copy_file "spec/support/pause_service.rb"

inject_into_file 'spec/rails_helper.rb', after: "# Add additional requires below this line. Rails is not loaded until this point!\n" do <<-'RUBY'

Dir['spec/support/**/*.rb'].each do |file|           
  require Rails.root.join(file).to_s                 
end                                                  

RUBY
end

inject_into_file 'spec/rails_helper.rb', after: "# config.filter_gems_from_backtrace(\"gem name\")\n" do <<-'RUBY'

  # include PageFragments in features
  config.include PageFragments, type: :feature

  # for pausing API requests and forcing API errors
  config.include PauseService, type: :feature
  config.include ForceApiError, type: :feature

  config.after(:each, type: :feature) do
    clear_api_error
    Rails.application.config.should_pause = nil
  end

  # render views for controller specs to render jbuilder templates
  config.render_views = true
RUBY
end

after_bundle do
  if yes?("Would you like to install React? (Y/n)")
    rails_command "webpacker:install:react"
  end
end
