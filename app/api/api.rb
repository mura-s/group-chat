class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::Jbuilder

  helpers do
    def warden
      env['warden']
    end

    def authenticate
      return true if warden.authenticated?

      error!('401 Unauthorized', 401)
    end

    def current_user
      warden.user
    end

    params :id do
      requires :id, type: Integer
    end

    params :content do
      requires :content, type: String
    end
  end

  resource :groups do
    before do
      authenticate
    end

    desc 'GET /api/groups/:id/members'
    params do
      use :id
    end
    get '/:id/members', jbuilder: 'groups/members' do
      @members = Group.find(params[:id]).users
    end

    desc 'POST /api/groups/:id/messages'
    params do
      use :id
      use :content
    end
    post '/:id/messages', jbuilder: 'groups/message' do
      @message = Group.find(params[:id]).messages.build(content: params[:content])
      @message.user_id = current_user.id
      if @message.save
        @user = current_user
      else
        error!('500 Internal Server Error', 500)
      end
    end
  end
end
