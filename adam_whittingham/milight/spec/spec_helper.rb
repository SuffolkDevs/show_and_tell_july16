require 'pry'

def production_code
  spec = caller[0][/spec.+\.rb/]
  './' + spec.gsub('_spec', '').gsub(/spec/, 'lib')
end

RSpec.configure do |config|
  config.default_formatter = 'doc' if config.files_to_run.one?

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
