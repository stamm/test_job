RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :request
  config.extend ControllerMacros, type: :controller
  config.extend ControllerMacros, type: :request
end