#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'rest-client'
require 'json'
require 'logger'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'haml'

session = "http://database:8081"
sysop = "http://database:8082"

set :port, 80
enable :sessions

helpers do
  def authenticated!
    u = authenticated?
    halt 401, 'Not authorized' if u.nil?
    return u
  end

  def authenticated?
    return nil unless session.has_key? :tokenid
    resp = RestClient.put "#{session}/token", session[:tokenid].to_json, content_type: :json, accept: :json
    return nil if resp.code != 200
    res = JSON.parse(resp.body)
    uresp = RestClient.get "#{sysop}/users/#{res[0]}"
    return nil if uresp.code != 200
    JSON.parse(uresp.body)
  end
end

get '/' do
  haml :index
end

get '/login' do
  haml :login
end

post '/login' do
  uresp = RestClient.get "#{sysop}/users/by-name/#{params[:name]}", accept: :json
  redirect back, notice: 'Invalid username or password' if uresp.code != 200
  user = JSON.parse(uresp.body)
  lresp = RestClient.post "#{session}/users/#{user['id']}/login", params[:password].to_json, content_type: :json, accept: :json
  redirect back, notice: 'Invalid username or password' if lresp.code != 200
  session[:tokenid] = JSON.parse(lresp.body)
  redirect '/', notice: 'You are now logged in!'
end

get '/register' do
  haml :register
end

get '/lists' do
  mresp = RestClient.get "#{sysop}/lists", accept: :json
  halt 500, 'Cannot retrieve all lists' if mresp.code != 200
  @mail_lists = JSON.parse(mresp.body)
  haml :lists
end

post '/lists' do
  mail_list = { address: params[:address],
                title: params[:title],
                user: authenticated!['id']
              }
  iresp = RestClient.post "#{sysop}/lists", mail_list.to_json, content_type: :json, accept: :json
  redirect back, notice: 'Cannot add this list' if iresp.code != 200
  redirect back
end

get '/lists/:id/delete' do
  @user = authenticated!
  iresp = RestClient.delete "#{sysop}/lists/#{params[:id]}", @user['id'].to_json, content_type: :json, accept: :json
  redirect back, notice: 'Cannot delete this list; insufficient rights?' if iresp.code != 200
  redirect back
end

get '/lists/:id/checkout' do
  @user = authenticated!
  iresp = RestClient.put "#{sysop}/lists/#{params[:id]}/unsubscribe", @user['id'].to_json, content_type: :json, accept: :json
  redirect back, notice: 'Cannot unsubscribe from the list; not subscribed?' if iresp.code != 200
  redirect back
end

get '/lists/:id/checkin' do
  @user = authenticated!
  iresp = RestClient.put "#{sysop}/lists/#{params[:id]}/subscribe", @user['id'].to_json, content_type: :json, accept: :json
  redirect back, notice: 'Cannot subscribe to the list; already subscribed?' if iresp.code != 200
  redirect back
end

post '/register' do
  redirect back, notice: "Passwords don't match" unless params[:password] == params[:password_confirmation]
  user = { name: params[:name],
           email: params[:email],
           password: params[:password],
           admin: !params[:is_admin].nil?
         }
  iresp = RestClient.post "#{session}/users", user.to_json, content_type: :json, accept: :json
  redirect back, notice: 'Cannot create new user; already exists?' if iresp.code != 200
  redirect '/', notice: 'Successfully registered!'
end

post '/logout' do
  RestClient.delete "#{session}/token", session[:tokenid].to_json, content_type: :json, accept: :json
  session.delete :tokenid
  redirect back, notice: 'Logged out!'
end

get '/contents/:id' do
  @user = authenticated!
  mresp = RestClient.get "#{sysop}/lists/#{params[:id]}", accept: :json
  redirect back, notice: 'Cannot view list; not exists?' if mresp.code != 200
  @mail_list = JSON.parse(mresp.body)
  halt 403, "Forbidden!" unless @user.is_admin || @user.id == @mail_list.owner
  cresp = RestClient.get "#{sysop}/lists/#{params[:id]}/subscribers", accept: :json
  halt 500, "Cannot retreive subscribers" if cresp.code != 200
  @contents = JSON.parse(cresp.body)
  haml :list_contents
end

get '/profile/:id' do
  @user = authenticated!
  halt 403, "Forbidden!" unless @user.is_admin || @user['id'] == params['id']
  lresp = RestClient.get "#{sysop}/users/#{params[:id]}/subscriptions", accept: :json
  halt 500, "Cannot retreive subscriptions" if lresp.code != 200
  @user_lists = JSON.parse(lresp.body)
  haml :profile
end 
