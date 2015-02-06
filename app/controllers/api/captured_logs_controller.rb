class Api::CapturedLogsController < ApplicationController
  def index
    @api_captured_logs = CapturedLog.eager_load(:portal).order(:id => :desc).limit(1000)
  end
end
