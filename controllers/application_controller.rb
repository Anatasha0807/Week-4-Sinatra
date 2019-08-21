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

  post '/new_game' do #1 start guess number
    session['level'] = params['game_level']
    set_secret_number

    session['total_chances'] = total_chances
    session['counter'] = counter

    redirect to('/game')
  end

  get '/game' do
    erb :game
  end

  post '/game' do
    session['guessed_number'] = params['guessed_number']

    if number_match
      erb :win
    else
      session['counter'] += 1

      if session['total_chances'] == session['counter']
        erb :gameover
      else
        erb :game
      end
    end
  end

  def text_try_again
    ["Ops, wrong answer!","Close enough. Try again!","Almost there!"].sample
  end

private
  def secret_number(level)
    if level == 'easy'
      secret_number = rand(1..30)
    elsif level == 'medium'
      secret_number = rand(1..50)
    else
      secret_number = rand(1..100)
    end
  end

  def number_match
    session['guessed_number'].to_i == session['secret_number']
  end

  def set_secret_number
    session['secret_number'] = secret_number(session['level'])
  end

  def total_chances
    3
  end

  def counter
    0
  end
end
