require 'rails_helper'

RSpec.describe ApplicationPresenter do
  describe '#created_at_in_words' do
    subject(:presenter) do
      Timecop.freeze(now - 6.days) do
        described_class.new(FactoryBot.create(:article))
      end
    end

    let(:now) { Time.now }

    it 'presents the created_at in human terms' do
      expect(presenter.created_at_in_words).to eq('6 days')
    end
  end
end
