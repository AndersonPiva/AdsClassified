class AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy]

  def create
    @advertisement = Advertisement.new(advertisement_params)
    @advertisement.user_id = current_user.id
    @advertisement.location = @advertisement.user.city.name
    @advertisement.status = "a venda"
    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to :back }
      else
        format.html { render :new }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @advertisement = Advertisement.find(params[:id])
    @images = @advertisement.images
  end

  def update
    respond_to do |format|
      if @advertisement.update(advertisement_params)
        format.html { redirect_to :back}
      else
        format.html { render :edit }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_ads
    if current_user.present?
      advertisement = Advertisement.find(params[:id])
      user = advertisement.user
      if current_user.id == user.id
        advertisement.destroy
        redirect_to "/usuarios/#{user.to_param}/anuncios"
      else
        redirect_to :back
      end
    else
      redirect_to new_user_session_path
    end
  end

  def sell
    advertisement = Advertisement.find(params[:id])
    if current_user.present?
      if current_user.id == advertisement.user.id
        advertisement.status = "vendido"
        advertisement.save
        redirect_to :back
      else
        redirect_to :back
      end
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    @advertisement.destroy
    redirect_to :back
  end

  private
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    def advertisement_params
      params.require(:advertisement).permit(:title, :price, :negotiable, :location, :description, :user_id, :status, :kind, images_attributes: [:id, :cover, :_destroy])
    end
end
