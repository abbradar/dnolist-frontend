#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'sequel'
require 'sequel_secure_password'
require 'logger'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'haml'

DB = Sequel.connect 'sqlite://test.db', loggers: [Logger.new($stderr)]
DB.sql_log_level = :debug

DB.create_table? :users do
  primary_key :id
  String :name, unique: true, null: false
  String :password_digest, null: false
  Bool :is_admin, null: false
end

DB.create_table? :mail_lists do
  primary_key :id
  String :address, null: false, unique: true
  String :title, null: false
  User :user, null: false
end

DB.create_table? :mail_users do
  User :user, null: false
  MailList :mail_list, null: false
  primary_key [:user, :mail_list], name: :pk
end

class MailList < Sequel::Model; end

class MailUser < Sequel::Model; end

class User < Sequel::Model
  plugin :secure_password
  plugin :validation_helpers

  def validate
    super
    validates_unique :name
  end
end

enable :sessions

helpers do
  def authenticated!
    u = authenticated?
    halt 401, 'Not authorized' if u.nil?
    return u
  end

  def authenticated?
    return nil unless session.has_key? :userid
    User[session[:userid]]
  end
end

get '/' do
  haml :index
end

get '/login' do
  haml :login
end

post '/login' do
  user = User[name: params[:name]]
  redirect back, notice: 'Invalid username or password' if user.nil? or user.authenticate(params[:password]).nil?
  session[:userid] = user.id
  redirect '/', notice: 'You are now logged in!'
end

get '/register' do
  haml :register
end

get '/lists' do
  @mail_lists = MailList.all
  haml :lists
end

post '/lists' do
  mail_list = MailList.new
  mail_list.address = params[:address]
  mail_list.title = params[:title]
  mail_list.user = authenticated!.id
  mail_list.save
  @mail_lists = MailList.all
  haml :lists
end

get '/lists/:id/delete' do
  mail_list = MailList.first(id: params[:id])
  halt 403, 'Forbidden!' if mail_list.user != authenticated!.id && ! authenticated!.is_admin
  MailList.where(id: params[:id]).delete
  redirect back
end

get '/lists/:id/checkout' do
  MailUser.where(mail_list: params[:id], user: authenticated!.id).delete
  redirect back
end

get '/lists/:id/checkin' do
  mail_user = MailUser.new
  mail_user.mail_list = params[:id]
  mail_user.user = authenticated!.id
  mail_user.save
  redirect back
end

post '/register' do
  user = User.new
  user.name = params[:name]
  user.password = params[:password]
  user.password_confirmation = params[:password_confirmation]
  user.is_admin = !params[:is_admin].nil?
  if not user.valid?
    user.errors.each { |field, error| flash[field] = "#{field}: #{error}" }
    redirect back
  end
  user.save
  redirect '/', notice: 'Successfully registered!'
end

post '/logout' do
  session.delete :userid
  redirect back, notice: 'Logged out!'
end

get '/contents/:id' do
  halt 403, "Forbidden!" unless authenticated!.is_admin
  @mail_list = MailList.first(id: params[:id])
  @contents = User.where(id: MailUser.where(mail_list: params[:id]).select(:user))
  haml  :list_contents
end

get '/profile/:id' do
  @user_lists = MailList.where(id: MailUser.where(user: authenticated!.id).select(:mail_list))
  haml :profile
end 

