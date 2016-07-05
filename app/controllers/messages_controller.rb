class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.sender.id
    if @message.sender.user.id == @message.receiver.user.id
      redirect_to :back
    else
      respond_to do |format|
        if @message.save
          format.html { redirect_to @message, notice: 'Message was successfully created.' }
          format.json { render :show, status: :created, location: @message }
        else
          format.html { render :new }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:name, :email, :phone, :comment, :receiver_id, :sender_id)
    end
end
