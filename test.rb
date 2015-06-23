#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'sequel'
require 'sequel_secure_password'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'haml'

DB = Sequel.connect 'sqlite://test.db'

DB.create_table? :users do
  primary_key :id
  String :name, unique: true, null: false
  String :password_digest, null: false
  Bool :is_admin, null: false
end

DB.create_table? :notes do
  primary_key :id
  String :message, null: false
  User :user, null: false
end

DB.create_table? :user_notes do
  User :user, null: false
  Note :note, null: false
  primary_key [:user, :note], name: :pk
end



class Note < Sequel::Model; end

class UserNote < Sequel::Model; end

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

get '/notes' do
  @notes = Note.all
  haml :notes
end

post '/notes' do
  note = Note.new
  note.message = params[:message]
  note.user = authenticated!.id
  note.save
  @notes = Note.all
  haml :notes
end

get '/notes/:id/delete' do
  note = Note.first(id: params[:id])
  halt 403, 'Forbidden!' if note.user != authenticated!.id && ! authenticated!.is_admin
  Note.where(id: params[:id]).delete
  redirect back
end

get '/notes/:id/checkout' do
  UserNote.where(note: params[:id], user: authenticated!.id).delete
  redirect back
end

get '/notes/:id/checkin' do
  user_note = UserNote.new
  user_note.note = params[:id]
  user_note.user = authenticated!.id
  user_note.save
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
