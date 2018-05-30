require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @report = reports(:one)
    @reportable = @report.reportable
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get reports_url
    assert_response :success
  end

  test "should get new" do
    get new_report_url(report: {reportable_id: @reportable.id, reportable_type: @reportable.class.to_s})
    assert_response :success
  end

  test "should create report" do
    assert_difference('Report.count') do
      post reports_url, params: { report: { description: @report.description, reportable_id: @report.reportable.id, reportable_type: @report.reportable.class.to_s } }
    end

    assert_redirected_to "/"
  end

  test "should show report" do
    get report_url(@report)
    assert_response :success
  end
end
