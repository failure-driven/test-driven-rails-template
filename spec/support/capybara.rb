# frozen_string_literal: true

require "capybara-inline-screenshot/rspec"

# Make browser slow down execution to see what's going on in the browser (when
# running non-Headless)
# with:
#       SLOMO_MS=100 bin/rspec
module SlomoBridge
  TIMEOUT = ENV.fetch("SLOMO_MS", "0").to_i / 1000.0

  def execute(*)
    sleep TIMEOUT if TIMEOUT > 0
    super
  end
end

Capybara.javascript_driver = :selenium_chrome

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  if ENV.fetch("GITHUB_ACTIONS", nil) == "true" || ENV.fetch("CODESPACES", nil) == "true"
    options.add_argument("--headless")
    options.add_argument("--disable-gpu")
  end

  args = {browser: :chrome}
  args[:options] = options if options
  # TODO: check this works?
  # args[:desired_capabilities] = {
  #   chromeOptions: {
  #     args: ["window-size=800,960"]
  #   }
  # }
  Capybara::Selenium::Driver.new(
    app,
    **args,
  ).tap do |driver|
    # Enable slomo mode
    driver.browser.send(:bridge).singleton_class.prepend(SlomoBridge)
  end
end

# Capybara::Screenshot.webkit_options = {
#   width: 1024,
#   height: 768
# }

# Capybara::Screenshot.autosave_on_failure = false
# Capybara::Screenshot.prune_strategy = :keep_last_run

Webdrivers.cache_time = 1.month.to_i

Capybara::Screenshot.register_driver(:selenium_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
