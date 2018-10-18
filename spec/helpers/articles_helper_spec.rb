require 'rails_helper'

RSpec.describe ArticlesHelper, type: :helper do
  describe '#article_path_with_slug' do
    it 'returns the article path with slug' do
      expect(helper.article_path_with_slug('uid', 'the_slug'))
        .to match(%r{/a/uid/the_slug})
    end
  end
end
