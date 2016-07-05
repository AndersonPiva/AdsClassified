class SearchsController < ApplicationController
  def search
    flash[:notice] = nil
    if params[:query].present?
      @users = User.search(params[:query], page: params[:page], per_page: 10)
      @advertisements = Advertisement.search(params[:query], page: params[:page], per_page: 10)
    else
      flash[:notice] = ''
    end
  end
end
