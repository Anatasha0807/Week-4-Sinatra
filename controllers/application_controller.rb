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
    session['guessed_number'] = nil
    session['secret_number'] = nil

    erb :level
  end

  post '/new_game' do
    session['level'] = params['game_level']

    redirect to('/game')
  end

  get '/game' do
    session['secret_number'] = secret_number(session['secret_number'])
    erb :game
  end

  post '/game' do
    session['guessed_number'] = params['guessed_number']

      if session['guessed_number'].to_i == session['secret_number']
        erb :win
      else
        erb :game
      end
    end
  end

  def secret_number(level)
    if level == 'easy'
      secret_number = rand(1..30)
    elsif level == 'medium'
      secret_number = rand(1..50)
    else level == 'hard'
      secret_number = rand(1..100)
  end
end

#   def secret_number
#     78
#   end
# end
