class UsersController < ApplicationController

  ## profile
  def profile
    @user = User.find(params[:id])
    @advertisements = Advertisement.where(user_id: @user.id).paginate(page: params[:page], per_page: 10).order("created_at DESC")
    @total_evaluations = @user.rated.evaluations.size
    @total_five = @user.rated.evaluations.where(star: 5).size
    @total_four = @user.rated.evaluations.where(star: 4).size
    @total_three = @user.rated.evaluations.where(star: 3).size
    @total_two = @user.rated.evaluations.where(star: 2).size
    @total_one = @user.rated.evaluations.where(star: 1).size
    if current_user.present?
      @favourites = current_user.favourites
    end
    if @total_evaluations != 0
      @media = ((((@total_five * 5) + (@total_four * 4) + (@total_three * 3) + (@total_two * 2) + @total_one).quo @total_evaluations).to_f).round(1)
    else
      @media = 0.0
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  ## timeline
  def timeline
    if current_user.present?
      @user = User.find(params[:id])
      @cities = City.all.order(name: :asc)
      @allAds = Advertisement.all.paginate(page: params[:page], per_page: 10).order("created_at DESC")
      following_ids = []
      @user.follows.each do |follow|
        following_ids << follow.followable_id
      end
      @followings_ads = Advertisement.where(user_id: following_ids).paginate(page: params[:page], per_page: 10).order("created_at DESC")
      @favourites = @user.favourites
    else
      redirect_to new_user_session_path
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  ## followers
  def followers
      @user = User.find(params[:id])
      @followers = @user.followers.sort_by!(&:created_at).reverse!.paginate(page: params[:page], per_page: 10)

      respond_to do |format|
        format.html
        format.js
      end
  end

  ## followings
  def followings
      @user = User.find(params[:id])
      @followings = @user.all_following.sort_by!(&:created_at).reverse!.paginate(page: params[:page], per_page: 10)

      respond_to do |format|
        format.html
        format.js
      end
  end

  ##acst_as_follower methods

  def follow
    if current_user.present?
      @user = User.find(params[:id])
      current_user.follow(@user)
      redirect_to :back
    else
      redirect_to new_user_session_path
    end
  end

  def unfollow
    if current_user.present?
      @user = User.find(params[:id])
      current_user.stop_following(@user)
      redirect_to :back
    else
      redirect_to new_user_session_path
    end
  end

  ## searchkick autocomplete
  def autocomplete
   users =  User.search(params[:query], autocomplete: true, limit: 10).map(&:name)
   advertisements = Advertisement.search(params[:query], autocomplete: true, limit: 10).map(&:title)
   render json: users + advertisements
  end

  ## allUsers page
  def allUsers
    @users = User.all.paginate(page: params[:page], per_page: 10).order("created_at DESC")

    respond_to do |format|
      format.html
      format.js
    end
  end

  ## evaluations page
  def evaluations
    @user = User.find(params[:id])
    @evaluations = @user.rated.evaluations.paginate(page: params[:page], per_page: 1).order("created_at DESC")
    @evaluations_five = @user.rated.evaluations.where(star: 5).paginate(page: params[:page], per_page: 2).order("created_at DESC")
    @evaluations_four = @user.rated.evaluations.where(star: 4).paginate(page: params[:page], per_page: 2).order("created_at DESC")
    @evaluations_three = @user.rated.evaluations.where(star: 3).paginate(page: params[:page], per_page: 2).order("created_at DESC")
    @evaluations_two = @user.rated.evaluations.where(star: 2).paginate(page: params[:page], per_page: 2).order("created_at DESC")
    @evaluations_one = @user.rated.evaluations.where(star: 1).paginate(page: params[:page], per_page: 2).order("created_at DESC")
    @total_evaluations = @user.rated.evaluations.size
    @total_five = @user.rated.evaluations.where(star: 5).size
    @total_four = @user.rated.evaluations.where(star: 4).size
    @total_three = @user.rated.evaluations.where(star: 3).size
    @total_two = @user.rated.evaluations.where(star: 2).size
    @total_one = @user.rated.evaluations.where(star: 1).size
    if @total_evaluations != 0
      @media = ((((@total_five * 5) + (@total_four * 4) + (@total_three * 3) + (@total_two * 2) + @total_one).quo @total_evaluations).to_f).round(1)
    else
      @media = 0.0
    end
    if current_user.present?
      @evaluation_current_user = @user.rated.evaluations.where(evaluator_id: current_user.evaluator.id).first
    end
  end

  ## advertisements
  def advertisements
    @user = User.find(params[:id])
    @advertisements = Advertisement.where(user_id: @user.id).paginate(page: params[:page], per_page: 10).order("created_at DESC")

    respond_to do |format|
      format.html
      format.js
    end
  end

  ## messages
  def messages
    if current_user.present?
      @user = User.find(params[:id])
      @messages = @user.receiver.messages.order("created_at DESC")
      @total_messages = @messages.size
      @total_messages_no_read = @messages.where(status: "nao lida").size
    else
      redirect_to new_user_session_path
    end
  end
end
