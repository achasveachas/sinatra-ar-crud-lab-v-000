require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "Hello World"
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    puts params
    @post = Post.create(name: params[:name], content: params[:content])
    erb :posts
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    erb :posts
  end

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find_by_id(params[:id]).update(:name => params[:name], :content => params[:content])
    erb :posts
  end

  delete '/posts/:id/delete' do
    @post = Post.find_by_id(params[:id])
    Post.destroy(@post.id)
    erb :deleted
  end
end
