class HealthcheckController < ApplicationController
  def index
    ActiveRecord::Base.connection
    render plain: "ok", status: 200
  end

  def deploy
    deploy = ENV.fetch("DEPLOY") { "development" }
    render plain: deploy, status: 200
  end
end
