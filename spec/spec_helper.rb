require 'customlogger'

module Helper
  def read_file(file_path_name)
    File.read(file_path_name)
  end
end

RSpec.configure do |config|
  config.include Helper

  config.after(:suite) do
    if File.directory?([ Dir.pwd, 'log'].join('/'))
      FileUtils.rm_rf([ Dir.pwd, 'log'].join('/'))
    end
  end
end