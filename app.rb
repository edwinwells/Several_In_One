require 'sinatra'
# require_relative 'isbn_refactored.rb'
# require_relative 'exact_change.rb'
# require_relative 'new_personal_details.rb'

get '/' do
    erb :initial_page
end

post '/' do
    erb :initial_page
end