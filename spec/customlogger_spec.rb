require 'spec_helper'

describe 'with Custom Logger' do

  describe 'with path call' do
    it 'will return current path if not specified' do
      CustomLogger.path = nil
      expect(CustomLogger.path).to eq [ Dir.pwd, '/log' ].join
    end

    it 'will return set log_path if was specified' do
      CustomLogger.path = '/saimon/lovell'
      expect(CustomLogger.path).to eq '/saimon/lovell'
    end
  end

  describe 'with file call' do
    it 'will return current file name if not specified' do
      CustomLogger.file = nil
      expect(CustomLogger.file).to eq 'custom_logger.html'
    end

    it 'will return set file name if was specified' do
      CustomLogger.file = 'saimon.lovell'
      expect(CustomLogger.file).to eq 'saimon.lovell'
    end
  end

  describe 'with title call' do
    it 'will return current title if not specified' do
      expect(CustomLogger.title).to eq 'Custom Logger'
    end

    it 'will return set title if was specified' do
      CustomLogger.title = 'Custom Logger Saimon Lovell'
      expect(CustomLogger.title).to eq 'Custom Logger Saimon Lovell'
    end
  end

end