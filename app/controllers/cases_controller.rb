class CasesController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to :new_case
  end

  def show
    @case = Case.find params[:id]
  end

  def new
    @case = Case.new
  end

  def create
    @case = Case.new case_params
    @case.email = current_user.email
    if @case.save
      redirect_to @case
    else
      render 'new'
    end
  end

private

  def case_params
    params.require(:case).permit :type, :uf, :reason, :notes
  end
end
