class ReportsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @report = Case.report    
  end
end
