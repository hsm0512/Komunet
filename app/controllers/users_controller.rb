class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(8)

    # キーワード検索
    if params[:keyword].present?
      @users = @users.where("name LIKE ? OR user_name LIKE ? OR organization_name LIKE ? OR department_name LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end 
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.published.page(params[:page]).per(8).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    # 自分（ログイン中ユーザー）が参加しているルーム一覧を取得
    @currentUserEntry = Entry.where(user_id: current_user.id)

    # 相手ユーザーが参加しているルーム一覧を取得
    @userEntry = Entry.where(user_id: @user.id)

    # 自分自身のプロフィールを見ている場合はDM機能の表示は不要のためスキップ
    if @user.id == current_user.id
    
    # 自分と相手が同じルーム（room_id）に入っていないかチェックし、共通のroom_idがあればそれを使ってチャット可能と判断して変数に保存
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      # すでにルームがあるから何もしない
      if @isRoom
      
      # 共通のルームがなければ新しいチャットルームをエントリー
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  private
  def user_params
    params.require(:user).permit(:name, :user_name, :profile_text, :organization_name, :department_name, :job_category_id, :profile_image)
  end
end
