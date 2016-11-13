require 'sinatra'
require 'mongoid'
require 'redcarpet'
require 'slim'

configure do
	Mongoid.load!("./database.yml")
end

class Page
	include Mongoid::Document 
	field :title, type: String
	field :text,  type: String
end


get '/pages' do
	@pages = Page.all
	@title = "Page List"
	erb :index
end

get '/pages/new' do
	@page = Page.new
	erb :new
end

post '/pages' do
	page = Page.create(params[:page])
	redirect to("/pages/#{page.id}")
end

get '/pages/:id' do
	@page = Page.find(params[:id])
	@title = @page.title
	erb :show
end


