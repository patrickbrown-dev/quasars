class ApplicationPresenter
  include ActionView::Helpers::DateHelper

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def created_at_in_words
    time_ago_in_words(@model.created_at)
  end
end
