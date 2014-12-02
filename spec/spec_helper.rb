require 'customlogger'

module Helper
  def read_file(file_path_name)
    File.read(file_path_name)
  end
end

RSpec.configure do |config|
  config.include Helper
end