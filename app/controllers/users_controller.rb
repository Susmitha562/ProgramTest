class UsersController < ApplicationController
   before_action :authenticate_user!
  
  api :GET,"/users", "This is inedx view of all"
  def index
     @users = User.all.paginate(page: params[:page], per_page: 5)
    # render json: @users, each_serializer: UserSerializer
  end
  api :POST,"/users", "This is create view of all"
  def create
    uploader = BabyUploader.new
    @user = User.new(first_name: params[:user][:first_name], last_name: params[:user][:last_name], email: params[:user][:email], baby: params[:user][:baby])
    @user.password = "test1234"
    @user.password_confirmation = "test1234"
    @user.date_of_birth = params[:user][:date_of_birth]
    uploader.store!(params[:user][:baby])
    if @user.valid?

      @user.save
      flash[:notice] = 'Successfully created a new post!'
      redirect_to root_path
    else
      puts @user.errors.full_messages
      flash[:alert] = 'Something went wrong...'
      render :new
    end
  end
  api :GET,"/users", "This is new view of all"
  def new
    @user = User.new
  end
  api :GET,"/users", "This is create edit of all"
  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def show
    @user = User.find(params[:id])
   # render json: @user, serializer: UserSerializer
  end
  api :GET,"/users", "This is delete of all"
  def destroy
    @user = User.find_by(id: params[:id])
    @user.delete
    redirect_to root_path
  end

  
  private 

  def user_params 
    params.permit(:first_name, :last_name, :email, :date_of_birth, :baby)
  end

  def current_user
    @user ||= User.find_by(id: params[:user_id])
  end
end
