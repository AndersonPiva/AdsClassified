class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:update, :destroy]

  def create
    @evaluation = Evaluation.new(evaluation_params)
    @evaluation.evaluator_id = current_user.evaluator.id
    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to :back }
      else
        format.html { render :new }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to :back, notice: 'Evaluation was successfully updated.' }
        format.json { render :show, status: :ok, location: @evaluation }
      else
        format.html { render :edit }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @evaluation.destroy
    redirect_to :back
  end

  private
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    def evaluation_params
      params.require(:evaluation).permit(:star, :comment, :rated_id, :evaluator_id)
    end
end
