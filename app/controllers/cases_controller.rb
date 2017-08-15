class CasesController < ApplicationController
  def show
    @case = Case.find(params[:id])
  end

  def new
  end

  def create
    @case = Case.new(case_params)
    if @case.save
      redirect_to @case
    else
      render 'new'
    end
  end

private

  def case_params
    params.require(:case).permit(:type, :uf, :reason, :notes)
  end
end
