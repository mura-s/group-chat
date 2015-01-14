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

    params :id do
      requires :id, type: Integer
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
  end
end
