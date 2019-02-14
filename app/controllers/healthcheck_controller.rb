class HealthcheckController < ApplicationController
  def index
    ActiveRecord::Base.connection
    render plain: message('healthy'), status: 200
  rescue StandardError => e
    logger.error(e)
    e.backtrace.map { |line| logger.error(line) }
    render plain: message('unhealthy'), status: 500
  end

  private

  def message(health)
    env     = Rails.env
    <<-MSG.strip_heredoc
      status:\t#{health}
      env:\t#{env}
    MSG
  end
end
