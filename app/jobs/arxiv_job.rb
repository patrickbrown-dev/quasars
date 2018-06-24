require 'open-uri'

class ArxivJob < ApplicationJob
  queue_as :default

  def perform
    page   = Nokogiri::HTML(open('https://arxiv.org/list/astro-ph/new'))
    keys   = page.css('dt')
    values = page.css('dd')
    user   = User.find_by(username: 'pab')

    keys.zip(values).each do |k, v|
      arxiv_id    = k.css('span').css('a')[0]['href']
      title       = v.css('.list-title').text.delete("\n").gsub('Title: ', '')
      authors     = v.css('.list-authors').text
      description = authors + "\n\n" + v.css('p').text
      url         = "https://arxiv.org#{arxiv_id}"

      break if Article.exists?(url: url)

      Article.create!(
        url:         url,
        title:       title,
        description: description,
        user:        user
      )
    end

    :ok
  end
end
