class RoomsController < ApplicationController
  before_action :authenticate_user!
    
  def index
    @rooms = current_user.rooms
  end

  def create
    other_user = User.find(params[:room][:user_id])
    # current_userが参加しているroomのなかで、other_userが参加しているroomを検索
    existing_room = current_user.entries.joins(:room)
                                        .where(entries: { user_id: other_user.id })
                                        .first

        if existing_room
            # 既存のルームがある場合はそのルームを使用
            redirect_to room_path(existing_room)
        else
            # 新しいルームを作成
            @room = Room.create
            # 現在のユーザーをルームに参加させる
            Entry.create(user_id: current_user.id, room_id: @room.id)
            # 相手のユーザーをルームに参加させる
            Entry.create(user_id: other_user.id, room_id: @room.id)

            redirect_to room_path(@room)
        end
    end

    def show
        @room = Room.find(params[:id])
        # メッセージを取得する際に、ユーザー情報も一緒に取得するように修正
        @messages = @room.messages.includes(:user).order(created_at: :asc)
        @message = Message.new
        @entries = @room.entries.includes(:user)

        # Roomで相手の名前表示するために記述
        @myUserId = current_user.id
    end

end