require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#asset_url' do
    it 'returns the absolute path of an asset' do
      expect(helper.asset_url('quasars_logo.svg'))
        .to match(%r{http://test.host/assets/quasars_logo})
    end
  end
end
