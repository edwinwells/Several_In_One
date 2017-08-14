require 'sinatra'
require_relative 'isbn_refactored.rb'
require_relative 'exact_change.rb'
require_relative "gameboard.rb"
require_relative "player.rb"
require_relative "game.rb"

class Severalweb < Sinatra::Base
enable :sessions

get '/' do
    erb :several_initial_page
end

get '/isbn' do
    erb :User_Input_ISBN_Number
end

get '/change' do
    erb :User_Input_Amount
end

get '/details' do
    erb :name
end

get '/tictactoe' do
    erb :initial_page
end

post '/name' do
    name = params[:name]
    redirect '/age?name=' + name
end


get '/age' do
    erb :age, :locals => {:name => params[:name]}
end

post '/age' do
    age = params[:age]
    name = params[:name]
    redirect '/location?name=' + name + '&age=' + age
end

get '/location' do
    erb :location, :locals=>{:name=>params[:name],:age=>params[:age]}
end

post '/location' do
    user_location = params[:user_location]
    age = params[:age]
    name = params[:name]
    redirect '/numbers?name=' + name + '&age=' + age + '&user_location=' + user_location
end

get '/numbers' do
    erb :numbers, :locals=>{:name=>params[:name],:age=>params[:age],:user_location=>params[:user_location]}
end
post '/numbers' do
    num1 = params[:num1]
    num2 = params[:num2]
    num3 = params[:num3]
    user_location = params[:user_location]
    age = params[:age]
    name = params[:name]

    redirect '/favorites?num1=' + num1 + '&num2=' + num2 + '&num3=' + num3 + '&name=' + name + '&age=' + age + '&user_location=' + user_location
end

get '/favorites' do
    num1 = params[:num1]
    num2 = params[:num2]
    num3 = params[:num3]
    user_location = params[:user_location]
    age = params[:age]
    name = params[:name]
    # sum_of_nums = params [:num1] + params[:num2] + params[:num3]

    sum_of_nums = num1.to_i + num2.to_i + num3.to_i

    if sum_of_nums > age.to_i
        age_compare = "Your favorite numbers added together are greater than your age!"

    elsif sum_of_nums < age.to_i
        age_compare = "Your favorite numbers added together are less than your age!"

    else
        age_compare = "Your favorite numbers added together are equal to your age!"
    end
        erb :favorites, :locals=>{:name=>params[:name], :age=>params[:age],:user_location=>params[:user_location],:num1=>params[:num1],:num2=>params[:num2],:num3=>params[:num3],:age_compare=>age_compare,:sum_of_nums=>sum_of_nums}
end

post '/remove_unwanted' do
    number = params[:isbn_string]
    session[:result] = remove_unwanted(number)

    if session[:result]==true 
        statement="\nCongratulations!\nYour ISBN #{number} is Valid!\nHave a nice day:-)\n\n"
    else
        statement="\nSorry 'bout your luck!\nYou got hold of a counterfeit ISBN!\nBetter luck next time...\n\n"
    end


    erb :showisbnresult, :locals => {:number => number, 
                               :result => session[:result], 
                               :statement => statement}
end

post '/exact_change' do
    number = params[:changevalue]
    session[:result] = exact_change(number)
    # "OK, for #{number}, you will need #{result}!  Get to countin'!!"
    erb :showinfo, :locals => {:number => number, 
                               :result => session[:result]}
end

get '/twohumans' do
    session[:playerX] = Player.new("X")
    session[:playerO] = Player.new("O")
    session[:reset] = "N"
    session[:freshgame] = HumanVersusHuman.new(session[:playerX], session[:playerO], session[:reset])
    session[:gameboard] = GameBoard.new
    session[:gametype] = 1
    gametype = params[:gametype]
    session[:current_player] = "X"
    erb :Basic_Table, :locals => {playerX: session[:playerX], playerO: session[:playerO], freshgame: session[:freshgame], reset: session[:reset],gameboard: session[:gameboard], gametype: session[:gametype], current_player: session[:current_player]}
end

get '/leveloneHumanX' do
    session[:playerX] = Player.new("X")
    session[:playerO] = ComputerSequential.new("O")
    session[:reset] = "N"
    session[:freshgame] = VersusSequential.new(session[:playerX], session[:playerO], session[:reset])
    session[:gameboard] = GameBoard.new
    session[:gametype] = 2
    gametype = params[:gametype]
    erb :Basic_Table, :locals => {playerX: session[:playerX], playerO: session[:playerO],freshgame: session[:freshgame], reset: session[:reset],gameboard: session[:gameboard], gametype: session[:gametype]}
end

get '/leveloneHumanO' do
    session[:playerX] = ComputerSequential.new("X")
    session[:playerO] = Player.new("O")
    session[:reset] = "N"
    session[:freshgame] = VersusSequential.new(session[:playerX], session[:playerO], session[:reset])
    session[:gameboard] = GameBoard.new
    session[:gameboard].setup = {
                       a1: "X", a2: " ", a3: " ",
                       b1: " ", b2: " ", b3: " ",
                       c1: " ", c2: " ", c3: " "
                       }
    session[:gametype] = 3
    gametype = params[:gametype]
    erb :Basic_Table, :locals => {playerX: session[:playerX], playerO: session[:playerO],freshgame: session[:freshgame], reset: session[:reset],gameboard: session[:gameboard], gametype: session[:gametype]}
end

get '/leveltwoHumanX' do
    session[:playerX] = Player.new("X")
    session[:playerO] = ComputerRandom.new("O")
    session[:reset] = "N"
    session[:freshgame] = VersusRandom.new(session[:playerX], session[:playerO], session[:reset])
    session[:gameboard] = GameBoard.new 
    session[:gametype] = 4
    gametype = params[:gametype]
    erb :Basic_Table, :locals => {playerX: session[:playerX], playerO: session[:playerO],freshgame: session[:freshgame], reset: session[:reset],gameboard: session[:gameboard], gametype: session[:gametype]}
end

get '/leveltwoHumanO' do
    session[:playerX] = ComputerRandom.new("X")
    session[:playerO] = Player.new("O")
    session[:reset] = "N"
    session[:freshgame] = VersusRandom.new(session[:playerX], session[:playerO], session[:reset])
    session[:gameboard] = GameBoard.new
    session[:gameboard].setup = {
                       a1: "X", a2: " ", a3: " ",
                       b1: " ", b2: " ", b3: " ",
                       c1: " ", c2: " ", c3: " "
                       }    
    session[:gametype] = 5
    gametype = params[:gametype]
    erb :Basic_Table, :locals => {playerX: session[:playerX], playerO: session[:playerO],freshgame: session[:freshgame], reset: session[:reset],gameboard: session[:gameboard], gametype: session[:gametype]}
end

get '/levelthreeHumanX' do
    session[:playerX] = Player.new("X")
    session[:playerO] = ComputerUnbeatable.new("O")
    session[:reset] = "N"
    session[:freshgame] = VersusUnbeatable.new(session[:playerX], session[:playerO], session[:reset])
    session[:gameboard] = GameBoard.new
    session[:gametype] = 6
    gametype = params[:gametype]
    erb :Basic_Table, :locals => {playerX: session[:playerX], playerO: session[:playerO],freshgame: session[:freshgame], reset: session[:reset],gameboard: session[:gameboard], gametype: session[:gametype]}
end

get '/levelthreeHumanO' do
    session[:playerX] = ComputerUnbeatable.new("X")
    session[:playerO] = Player.new("O")
    session[:reset] = "N"
    session[:freshgame] = VersusUnbeatable.new(session[:playerX], session[:playerO], session[:reset])
    session[:gameboard] = GameBoard.new
    session[:gameboard].setup = {
                       a1: "X", a2: " ", a3: " ",
                       b1: " ", b2: " ", b3: " ",
                       c1: " ", c2: " ", c3: " "
                       }    
    session[:gametype] = 7
    gametype = params[:gametype]
    # session[:current_player] = "X"
    erb :Basic_Table, :locals => {playerX: session[:playerX], playerO: session[:playerO],freshgame: session[:freshgame], reset: session[:reset],gameboard: session[:gameboard], gametype: session[:gametype]}
end
 
post '/move' do
    square = [:square]
    freshgame = params[:freshgame]
    playerX = params[:playerX]
    playerO = params[:playerO]
    gameboard = params[:gameboard]
    reset = params[:reset]
    value = params[:value]
    gametype = params[:gametype]
    current_player = session[:current_player]
        #set-up for session[:gametype] == 2,4,6:
        if session[:gametype] == 2 ||
           session[:gametype] == 4 ||
           session[:gametype] == 6  
           session[:current_player] == "X"
           redirect "/invalid_move?player=X&action=/moveX" if session[:gameboard].check_position?(params[:square]) == false
           session[:playerX].get_move(session[:gameboard], "X", params[:square])
             if (session[:freshgame].check_for_wins(session[:gameboard].setup, "X") == false) && (session[:gameboard].check_full?() == true) == true
                    redirect "/drawn_game"
             elsif (session[:freshgame].check_for_wins(session[:gameboard].setup, "X") == true) && (session[:gameboard].check_full?() == true) == true
                    redirect "/winner?player=X"
             elsif (session[:freshgame].check_for_wins(session[:gameboard].setup, "X") == true) && (session[:gameboard].check_full?() == false) == true
                    redirect "/winner?player=X"
             end                                
           redirect "/drawn_game" if session[:gameboard].check_full?() == true          
           session[:playerO].get_move(session[:gameboard],"O")
             if (session[:freshgame].check_for_wins(session[:gameboard].setup, "O") == false) && (session[:gameboard].check_full?() == true) == true
                    redirect "/drawn_game"
             elsif (session[:freshgame].check_for_wins(session[:gameboard].setup, "O") == true) && (session[:gameboard].check_full?() == true) == true
                    redirect "/winner?player=O"
             elsif (session[:freshgame].check_for_wins(session[:gameboard].setup, "O") == true) && (session[:gameboard].check_full?() == false) == true
                    redirect "/winner?player=O"
             end
        #set-up for session[:gametype] == 3,5,7:
        elsif
             session[:gametype] == 3 ||
             session[:gametype] == 5 ||
             session[:gametype] == 7 
             session[:current_player] == "O"
             redirect "/invalid_move?player=O&action=/moveO" if session[:gameboard].check_position?(params[:square]) == false
             session[:playerO].get_move(session[:gameboard], "O", params[:square])
             if (session[:freshgame].check_for_wins(session[:gameboard].setup, "O") == false) && (session[:gameboard].check_full?() == true) == true
                    redirect "/drawn_game"
             elsif (session[:freshgame].check_for_wins(session[:gameboard].setup, "O") == true) && (session[:gameboard].check_full?() == true) == true
                    redirect "/winner?player=O"
             elsif (session[:freshgame].check_for_wins(session[:gameboard].setup, "O") == true) && (session[:gameboard].check_full?() == false) == true
                    redirect "/winner?player=O"
             end
             session[:playerX].get_move(session[:gameboard],"X")
             redirect "/winner?player=X" if session[:freshgame].check_for_wins(session[:gameboard].setup, "X") == true       
             redirect "/drawn_game" if session[:gameboard].check_full?() == true    
         #  Good for session[:gametype] == 1:
        else
           current_player = params[:current_player]
           redirect "/invalid_move?player=#{current_player}&action=/move#{current_player}" if session[:gameboard].check_position?(params[:square]) == false
           session[:gameboard].set_position(params[:square], session[:current_player])
           redirect "/winner?player=#{session[:current_player]}" if session[:freshgame].check_for_wins(session[:gameboard].setup, session[:current_player]) == true
           redirect "/drawn_game" if session[:gameboard].check_full?() == true          
           if session[:current_player] == "X"
                session[:current_player] = "O"
           else
                session[:current_player] = "X"
           end  
    end
    erb :Basic_Table, :locals => {playerX: session[:playerX], playerO: session[:playerO],freshgame: session[:freshgame], reset: session[:reset], gameboard: session[:gameboard], value: value, gametype: session[:gametype], current_player: current_player}
end

get '/invalid_move' do
    player = params[:player]
    action = params[:action]
    erb :Invalid_Move, :locals => {playerX: session[:playerX], playerO: session[:playerO],freshgame: session[:freshgame], reset: session[:reset], gameboard: session[:gameboard], gametype: session[:gametype], player: player, action: action}
end

get '/Basic_Table.erb' do
    erb :Basic_Table, :locals => {playerX: session[:playerX], playerO: session[:playerO],freshgame: session[:freshgame], reset: session[:reset], gameboard: session[:gameboard], gametype: session[:gametype], action: session[:action]}
end

get "/drawn_game" do
    erb :drawn_game, :locals => {gameboard: session[:gameboard]}
end

get "/winner" do
    player = params[:player]
        erb :win, :locals => {gameboard: session[:gameboard], player: player}
end
end