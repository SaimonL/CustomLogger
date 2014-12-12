require 'spec_helper'

describe 'with Custom Logger' do

  describe 'with loggin file' do
    before(:all) do
      CustomLogger.path = Dir.pwd
      CustomLogger.file = 'delete-me.html'
      @file_location = [ CustomLogger.path, CustomLogger.file ].join '/'
    end

    after(:all) { File.delete [ CustomLogger.path, CustomLogger.file ].join '/' }

    describe 'with error loggin' do
      before(:all) do
        CustomLogger.error('this is an error', 'hello')
        @data = read_file(@file_location)
      end

      it 'will add error message to the html file' do
        expect(@data).to include 'this is an error'
      end

      it 'will add error title to the html file' do
        expect(@data).to include '<header>hello</header>'
      end
    end

    describe 'with warning loggin' do
      before(:all) do
        CustomLogger.warning('this is an warning', 'hi there')
        @data = read_file(@file_location)
      end

      it 'will add error message to the html file' do
        expect(@data).to include 'this is an warning'
      end

      it 'will add error title to the html file' do
        expect(@data).to include '<header>hi there</header>'
      end
    end

    describe 'with debug loggin' do
      before(:all) do
        CustomLogger.debug('this is an debug', 'hi you')
        @data = read_file(@file_location)
      end

      it 'will add error message to the html file' do
        expect(@data).to include 'this is an debug'
      end

      it 'will add error title to the html file' do
        expect(@data).to include '<header>hi you</header>'
      end
    end

    describe 'with info loggin' do
      before(:all) do
        CustomLogger.info('this is an info', 'hello you')
        @data = read_file(@file_location)
      end

      it 'will add error message to the html file' do
        expect(@data).to include 'this is an info'
      end

      it 'will add error title to the html file' do
        expect(@data).to include '<header>hello you</header>'
      end
    end

    describe 'with raw loggin' do
      before(:all) do
        CustomLogger.raw('this is an raw', 'hello abc')
        @data = read_file(@file_location)
      end

      it 'will add error message to the html file' do
        expect(@data).to include 'this is an raw'
      end

      it 'will add error title to the html file' do
        expect(@data).to include '<header>hello abc</header>'
      end
    end

    describe 'with new_line' do
      before(:all) do
        CustomLogger.new_line
        @data = read_file(@file_location)
      end

      it 'will add a section' do
        expect(@data).to include '<section><hr></section>'
      end
    end

    describe 'with cleanup' do
      before(:all) do
        CustomLogger.clear
        @data = read_file(@file_location)
      end

      it 'will cleanup file log' do
        expect(@data).to_not include '<header>hello abc</header>'
      end
    end

    describe 'with no file' do
      before(:each) { File.delete([ CustomLogger.path, CustomLogger.file ].join('/')) }

      it 'will be able to create a file on the fly' do
        expect(CustomLogger.error('ss saimon')).to eq 'ss saimon'
      end
    end

    describe 'with auto clear being on' do
      after(:all) { CustomLogger.auto_clear = false }
      before(:all) do
        CustomLogger.clear 
        CustomLogger.auto_clear = true
      end

      before(:each) { CustomLogger.info('Hello there') }
      
      it 'will clear the old log' do
        CustomLogger.error('ss saimon')
        @data = read_file(@file_location)
        expect(@data).to_not include 'Hello there'
      end

      it 'will show the most recet log' do
        CustomLogger.error('ss saimon')
        CustomLogger.error('foo bar')
        @data = read_file(@file_location)
        expect(@data).to include 'foo bar'
      end

      it 'will show the most recet log and not previous' do
        CustomLogger.error('ss saimon')
        CustomLogger.error('foo bar')
        @data = read_file(@file_location)
        expect(@data).to_not include 'ss saimon'
      end
    end
  end
end