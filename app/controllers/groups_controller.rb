class GroupsController < ApplicationController
  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build(group_params)
    if current_user.save
      flash[:notice] = "グループを作成しました。"
      redirect_to chats_index_path
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
    @user = User.new
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:notice] = "グループを編集しました。"
      redirect_to chats_index_path
    else
      render 'edit'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:notice] = "グループを削除しました。"
    redirect_to chats_index_path
  end

  def add_user
    @user = User.find_by(add_user_params)
    if @user
      @group = current_user.groups.find(params[:group_id])
      @group.users << @user
      flash[:notice] = "グループにユーザを追加しました。"
    else
      flash[:alert] = "指定されたユーザは存在しません。"
    end

    redirect_to chats_index_path
  end

  def leave
    current_user.groups.delete(params[:group_id])
    flash[:notice] = "グループから抜けました。"
    redirect_to chats_index_path
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def add_user_params
    params.require(:user).permit(:email)
  end
end
