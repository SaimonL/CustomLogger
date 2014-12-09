require 'spec_helper'

describe 'with Custom Logger' do

  describe 'with path call' do
    it 'will return current path if not specified' do
      expect(CustomLogger.path).to eq [ Dir.pwd, '/log' ].join
    end

    it 'will return set log_path if was specified' do
      CustomLogger.path = '/saimon/lovell'
      expect(CustomLogger.path).to eq '/saimon/lovell'
    end
  end

  describe 'with file call' do
    it 'will return current file name if not specified' do
      expect(CustomLogger.file).to eq 'CustomLogger.html'
    end

    it 'will return set file name if was specified' do
      CustomLogger.file = 'saimon.lovell'
      expect(CustomLogger.file).to eq 'saimon.lovell'
    end
  end

  describe 'with title call' do
    it 'will return current title if not specified' do
      expect(CustomLogger.title).to eq 'Custome Logger'
    end

    it 'will return set title if was specified' do
      CustomLogger.title = 'Custome Logger Saimon Lovell'
      expect(CustomLogger.title).to eq 'Custome Logger Saimon Lovell'
    end
  end

  describe 'with error colors' do
    it 'will have default error colors' do
      expect( CustomLogger.error_colors
        ).to eq ({ error: '#8b0000', warning: '#6d422e', debug: '#ececec',
                   info: '#285b75' })
    end

    it 'will allow to set error color' do
      CustomLogger.error_color(:error, 'lovell')
      expect( CustomLogger.error_colors
      ).to eq ({ error: 'lovell', warning: '#6d422e', debug: '#ececec',
                 info: '#285b75' })
    end

    it 'will allow to set warning color' do
      CustomLogger.error_color(:warning, 'slovell')
      expect( CustomLogger.error_colors
      ).to eq ({ error: 'lovell', warning: 'slovell', debug: '#ececec',
                 info: '#285b75' })
    end

    it 'will allow to set debug color' do
      CustomLogger.error_color(:debug, 'saimon')
      expect( CustomLogger.error_colors

      ).to eq ({ error: 'lovell', warning: 'slovell', debug: 'saimon',
                 info: '#285b75' })
    end

    it 'will allow to set debug color' do
      CustomLogger.error_color(:info, 'ssl')
      expect( CustomLogger.error_colors

      ).to eq ({ error: 'lovell', warning: 'slovell', debug: 'saimon',
                 info: 'ssl' })
    end
  end

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
        expect(CustomLogger.error = 'ss saimon').to eq 'ss saimon'
      end

      it 'will return logged warning' do
        expect(CustomLogger.warning = 'ss saimon 123').to eq 'ss saimon 123'
      end

      it 'will return logged info' do
        expect(CustomLogger.info = 'ss saimon 123 abc').to eq 'ss saimon 123 abc'
      end

      it 'will return logged raw' do
        expect(CustomLogger.raw = 'saimon 123 abc').to eq 'saimon 123 abc'
      end
    end
  end

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
        expect(CustomLogger.error = 'ss saimon').to eq 'ss saimon'
      end
    end
  end

end