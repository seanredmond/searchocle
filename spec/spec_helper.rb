require "bundler/setup"
require "searchocle"
require "webmock/rspec"
require "marcxella"

SPEC_DIR = File.dirname(__FILE__)
RESP_DIR = File.join(SPEC_DIR, "responses")
RESP_30594426 = File.new(File.join(RESP_DIR, "30594426.txt")).read
RESP_SRU = File.new(File.join(RESP_DIR, "sru-zora-neal-hurston.txt")).read


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each)  do
    stub_request(:get, "worldcat.org/webservices/catalog/content/30594426").
      with(query: {"wskey" => "testkey"}).
      to_return(RESP_30594426)

    stub_request(:get, "worldcat.org/webservices/catalog/search/worldcat/sru").
      with(query: {"wskey" => "testkey",
                   "query" => "srw.au=%22Zora%20Neale%20Hurston%22%20and%20srw.ti=%22Novels%20and%20stories%22"}).
      to_return(RESP_SRU)

  end

end
