class FavouritesController < ApplicationController
  # Favourites view
  def favourite
    if current_user.present?
      @user = User.find(params[:id])
      @favourites = @user.favourites
      @advertisements = []
      @favourites.each do |favourite|
        @advertisements << favourite.advertisement
      end
      @advertisements.sort_by!(&:created_at).reverse!
      @advertisements = @advertisements.paginate(page: params[:page], per_page: 10)
    else
      redirect_to new_user_session_path
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  #Favourites methods

  def addFavourite
    if current_user.present?
      advertisement = Advertisement.find(params[:id])
      favourite = Favourite.new user_id: current_user.id, advertisement_id: advertisement.id
      favourite.save
      redirect_to :back
    else
      redirect_to new_user_session_path
    end
  end

  def removeFavourite
    if current_user.present?
      advertisement = Advertisement.find(params[:id])
      favourite = Favourite.where(advertisement_id: advertisement.id).first
      favourite.destroy
      redirect_to :back
    else
      redirect_to new_user_session_path
    end
  end
end
