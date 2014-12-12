require 'spec_helper'

describe 'with Custom Logger' do
  describe 'with error colors' do
    it 'will have default error colors' do
      expect( CustomLogger.error_colors
        ).to eq ({ error: '#8b0000', warning: '#5e3927', debug: '#004000',
                   info: '#1b3d4f' })
    end

    it 'will allow to set error color' do
      CustomLogger.error_color(:error, 'lovell')
      expect( CustomLogger.error_colors
      ).to eq ({ error: 'lovell', warning: '#5e3927', debug: '#004000',
                 info: '#1b3d4f' })
    end

    it 'will allow to set warning color' do
      CustomLogger.error_color(:warning, 'slovell')
      expect( CustomLogger.error_colors
      ).to eq ({ error: 'lovell', warning: 'slovell', debug: '#004000',
                 info: '#1b3d4f' })
    end

    it 'will allow to set debug color' do
      CustomLogger.error_color(:debug, 'saimon')
      expect( CustomLogger.error_colors

      ).to eq ({ error: 'lovell', warning: 'slovell', debug: 'saimon',
                 info: '#1b3d4f' })
    end

    it 'will allow to set debug color' do
      CustomLogger.error_color(:info, 'ssl')
      expect( CustomLogger.error_colors

      ).to eq ({ error: 'lovell', warning: 'slovell', debug: 'saimon',
                 info: 'ssl' })
    end
  end
end