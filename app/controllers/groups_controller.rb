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

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
