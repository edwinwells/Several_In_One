require 'sinatra'
require_relative 'C:/Users/edwin/mystuff/ISBN_Refactored/isbn_refactored.rb'
require_relative 'C:/Users/edwin/mystuff/Exact_Change/exact_change.rb'


get '/' do
    erb :initial_page
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

post '/remove_unwanted(isbn_string)' do
    number = params[:isbn_string]
    result = remove_unwanted(number)

    if result==true 
        statement="\nCongratulations!\nYour ISBN #{number} is Valid!\nHave a nice day:-)\n\n"
    else
        statement="\nSorry 'bout your luck!\nYou got hold of a counterfeit ISBN!\nBetter luck next time...\n\n"
    end
end

post '/exact_change(changevalue)' do
    number = params[:changevalue]
    result = exact_change(number)
    # "OK, for #{number}, you will need #{result}!  Get to countin'!!"
    erb :showinfo, :locals => {:number => number, 
                               :result => result}
end

# post '/' do
#     erb :initial_page
# end