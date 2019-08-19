class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  # set public folder for static files
  set :public_folder, File.expand_path('../../public', __FILE__)

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../../views', __FILE__)

  enable :sessions

  get '/' do
    erb :index
  end

  get '/level' do
    erb :level
  end

  post '/new_game' do
    session['level'] = params['game_level']
    erb :game
  end

end
