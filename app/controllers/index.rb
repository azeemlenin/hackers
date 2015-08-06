get '/' do
  # Look in app/views/index.erb
  @post = Post.all
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.where(email: params[:user][:email])
  @auth = @user.authenticate(params[:user][:email], params[:user][:password])
  if @auth == nil
    redirect "/"
  else
    session[:user_id] = @auth.id
    redirect "/user_page"
  end
end

get '/sign_up' do
  erb :sign_up
end

post '/create_user' do

  @user = User.create(params[:user])

  if @user.valid?
    session[:user_id] = @user.id
    redirect "/user_page"
  else
    redirect "/oops"
  end
end

get '/oops' do
  erb :fuck_off
end

get '/user_page' do
  @user = User.find(session[:user_id])
  @post = @user.posts
  # byebug
  erb :user_page
end

get '/create_post' do
  @user = User.find(session[:user_id])
  erb :create_post
end

post '/create_post' do
  @user = User.find(session[:user_id])
  @post = Post.new(params[:post])
  if @post.save
    @user.posts << @post
    redirect "/user_page"
  else
    redirect "/create_post"
  end
end

get '/delete/:p_id' do
  @post = Post.find(params[:p_id])
  @delete = @post.destroy  if @post.user.id == session[:user_id]
  redirect "/user_page"
end

get '/post/:p_id' do
  # byebug
  @user = User.find(session[:user_id])
  @post = Post.find(params[:p_id])
  @comments = @post.comments.all
  erb :show_post
end

post '/create_comment' do
  # byebug
  @comment = Comment.new(params[:comment])
  @post = @comment.post
  if @comment.save
    "/post/#{@post.id}"
  else
    "error"
  end
end

delete '/logout' do
  session[:user_id] = nil
  redirect "/"
end

get '/show' do
  @user = User.find(session[:user_id])
  @post = Post.all
  erb :all
end

get '/edit/:p_id' do
  @post = Post.find_by_id(params[:p_id])
  @user = User.find_by_id(session[:user_id])
  erb :edit
end

put '/edit/:p_id' do
  @post = Post.find_by_id(params[:p_id])
  @update = @post.update(body: params[:post][:body])
  redirect "/user_page"
end