class HealthcheckController < ApplicationController
  def index
    ActiveRecord::Base.connection
    render plain: "ok", status: 200
  end
end
