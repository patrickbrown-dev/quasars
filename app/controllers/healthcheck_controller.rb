class HealthcheckController < ApplicationController
  def index
    ActiveRecord::Base.connection
    env     = Rails.env
    deploy  = ENV.fetch("DEPLOY") { "local" }
    sha     = `git log -n 1 --format=%h`
    message = <<-MSG.strip_heredoc
      status:\tok
      env:\t#{env}
      deploy:\t#{deploy}
      sha:\t#{sha}
    MSG

    render plain: message, status: 200
  end
end
