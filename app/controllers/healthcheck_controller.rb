class HealthcheckController < ApplicationController
  def index
    ActiveRecord::Base.connection
    render plain: message("healthy"), status: 200
  rescue => e
    logger.error(e)
    render plain: message("unhealthy"), status: 500
  end

  private
  def message(health)
    env     = Rails.env
    deploy  = ENV.fetch("DEPLOY") { "local" }
    sha     = `git log -n 1 --format=%h`
    message = <<-MSG.strip_heredoc
      status:\t#{health}
      env:\t#{env}
      deploy:\t#{deploy}
      sha:\t#{sha}
    MSG
  end
end
