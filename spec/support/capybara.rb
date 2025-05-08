require 'capybara/rspec'
require 'selenium-webdriver'

# Configuração base para RackTest (testes sem JavaScript)
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, headers: { 'HTTP_ACCEPT' => 'text/html' })
end

# Configuração para testes com JavaScript
Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: 'http://chrome:4444/wd/hub',
    options: options
  )
end

# Configurações comuns
Capybara.server_host = '0.0.0.0'
Capybara.server_port = ENV.fetch('CAPYBARA_SERVER_PORT', 3001)
Capybara.app_host = ENV.fetch('CAPYBARA_APP_HOST') { "http://web:#{Capybara.server_port}" }
Capybara.default_max_wait_time = 10

# Driver padrão baseado no tipo de teste
Capybara.default_driver = :rack_test
Capybara.javascript_driver = :headless_chrome

# Configuração para Devise
RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
  config.include Devise::Test::IntegrationHelpers, type: :feature

  config.before(:each, type: :feature) do |example|
    if example.metadata[:js]
      Capybara.current_driver = Capybara.javascript_driver
    else
      Capybara.current_driver = Capybara.default_driver
    end
  end

  config.after(:each, type: :feature) do
    Warden.test_reset!
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
