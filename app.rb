require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/count.rb'

before do
  if Count.all.size == 0
    Count.create(number: 0)
  end
end

get '/' do
  redirect "/count"
end

get '/count' do
  @count = Count.all.order(:id)
  erb :index
end

post '/:id/plus' do
  count = Count.find(params[:id])
  count.number = count.number + 1
  count.save
  redirect '/count'
end

post '/:id/minus' do
  count = Count.find(params[:id])
  count.number = count.number - 1
  count.save
  redirect '/count'
end

post "/:id/clear" do
  count = Count.find(params[:id])
  count.number = 0
  count.save
  redirect "/count"
end

post "/counter" do
  Count.create(number:0)
  redirect "/count"
end  