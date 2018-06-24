class ReportsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index,
                                            :show, :resolve]
  before_action :moderators_only!, only: [:index, :show, :resolve]
  before_action :set_report, only: [:show, :resolve]

  def index
    @reports = Report.all
  end

  def show; end

  def new
    @report = Report.new(report_params)
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user

    if @report.save
      redirect_to '/', notice: 'Report was successfully created.'
    else
      render :new
    end
  end

  def resolve
    @report.resolved_at = Time.now
    @report.save!
    redirect_to reports_url
  end

  private

  def moderators_only!
    return if current_user&.moderator
    raise ActionController::RoutingError, 'Not Found'
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(
      :description,
      :reportable,
      :reportable_id,
      :reportable_type
    )
  end
end
