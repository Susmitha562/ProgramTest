class UsersController < ApplicationController
   before_action :authenticate_user!
  def index
     @users = User.all.paginate(page: params[:page], per_page: 1)
    # render json: @users, each_serializer: UserSerializer
  end

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

  def new
    @user = User.new
  end

  def edit
  end

  def update
  end

  def show
    @user = User.find(params[:id])
   # render json: @user, serializer: UserSerializer
  end

  def delete
  end

  private 

  def user_params 
    params.permit(:first_name, :last_name, :email, :date_of_birth, :baby)
  end
end
