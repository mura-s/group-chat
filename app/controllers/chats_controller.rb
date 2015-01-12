class ChatsController < ApplicationController
  def index
    @user = current_user
    @groups = @user.groups.all
  end
end
