RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

# Associated object must be saved in Sequel
# See https://stackoverflow.com/a/43592300/825563
# and https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#build-strategies-1
FactoryBot.use_parent_strategy = false
FactoryBot.define { to_create { |model| model.save } }
