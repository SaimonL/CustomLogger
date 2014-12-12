require 'spec_helper'

describe 'with Custom Logger' do
  describe 'with logging message' do
    before(:each) do
      allow(CustomLogger).to receive(:log).and_return(true)
    end

    it 'will return new line html code when new line is called' do
      expect(CustomLogger.new_line).to eq '<section><hr></section>'
    end

    describe 'with title' do
      it 'will return logged error' do'<section><hr></section>'
        expect(CustomLogger.error('ss saimon', 'my title')).to eq 'ss saimon'
      end

      it 'will return logged warning' do
        expect(CustomLogger.warning('ss saimon 123', 'my title')).to eq 'ss saimon 123'
      end

      it 'will return logged info' do
        expect(CustomLogger.info('ss saimon 123 abc', 'my title')).to eq 'ss saimon 123 abc'
      end

      it 'will return logged raw' do
        expect(CustomLogger.raw('saimon 123 abc', 'my title')).to eq 'saimon 123 abc'
      end
    end

    describe 'without title' do
      it 'will return logged error' do
        expect(CustomLogger.error('ss saimon')).to eq 'ss saimon'
      end

      it 'will return logged warning' do
        expect(CustomLogger.warning('ss saimon 123')).to eq 'ss saimon 123'
      end

      it 'will return logged info' do
        expect(CustomLogger.info('ss saimon 123 abc')).to eq 'ss saimon 123 abc'
      end

      it 'will return logged raw' do
        expect(CustomLogger.raw('saimon 123 abc')).to eq 'saimon 123 abc'
      end
    end
  end
end