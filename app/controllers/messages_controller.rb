class MessagesController < ApplicationController
    before_action :authenticate_user!, only: [:create]

   def create
    if Entry.exists?(user_id: current_user.id, room_id: params[:message][:room_id])
        @message = Message.new(message_params)
        @message.user_id = current_user.id
        if @message.save
            redirect_to room_path(@message.room_id)
        else
            flash[:alert] = "メッセージの送信に失敗しました"
            redirect_back(fallback_location: root_path)
        end
    else
        redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
end
