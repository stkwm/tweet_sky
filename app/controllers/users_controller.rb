class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index,:show,:edit,:update,:logout,:likes,:follows]}
  before_action :forbid_login_user, {only: [:new,:create,:login_form,:login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "アクセス権限がありません"
      redirect_to("/posts\index")
    end
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: params[:id]).order(created_at: :desc)
    @follower_count = Follow.where(followed_id: params[:id]).count
    @follow_count = Follow.where(user_id: params[:id]).count
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]#params[:user][:name]
    @user.email = params[:email]#params[:user][:email]
    @user.self_intro = params[:self_intro]
    @user.image_name = "#{@user.id}.jpg"
    image = params[:image]
    if image
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def likes 
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: params[:id]).order(created_at: :desc)
    @follower_count = Follow.where(followed_id: params[:id]).count
    @follow_count = Follow.where(user_id: params[:id]).count
  end
  
  def follows
    @user = User.find_by(id: params[:id])
    @follows = Follow.where(user_id: @current_user.id)
    @follows.each do |follow|
      @posts = Post.where(user_id: follow.followed_id).order(created_at: :desc)
    end
    @follower_count = Follow.where(followed_id: params[:id]).count
    @follow_count = Follow.where(user_id: params[:id]).count
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name], 
      email: params[:email], 
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザーを登録しました"
      redirect_to("/posts/index")
    else
      render("users/new")
    end
  end
  
  def login_form
    @email = ""
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else 
      @email = params[:email]
      @err_msg = "メールアドレスまたはパスワードが正しくありません"
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end
end
