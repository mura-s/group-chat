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

    desc 'GET /api/groups/:id/messages'
    params do
      use :id
    end
    get '/:id/messages', jbuilder: 'groups/messages' do
      @messages = Message.where(group_id: params[:id]).limit(50).includes(:user)
      @last_get_message_time = Time.zone.now.to_s
    end

    desc 'GET /api/groups/:id/messages/:last_get_message_time'
    params do
      use :id
    end
    get '/:id/messages/:last_get_message_time', jbuilder: 'groups/messages' do
      time = Time.zone.parse(params[:last_get_message_time])
      @messages = Message.where(
                    'group_id = ? and created_at > ?', params[:id], time
                  ).includes(:user)
      @last_get_message_time = Time.zone.now.to_s
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
