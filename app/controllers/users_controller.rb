class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :delete_picture, :index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:show, :destroy, :delete_picture, :index]

  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end


  def show
    @user = User.find(params[:id])
    
    @answers = @user.answers.paginate(page: params[:page])
    @questions = @user.questions.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Benutzer gelöscht"
    redirect_to users_url
  end

  def create
    name  = Faker::Name.name
    password = "password"
     @user = User.create!(name:  name,
               password:              password,
               password_confirmation: password)
               
    @user.name = "Benutzer "+@user.id.to_s
    @user.display_name = @user.name
    @user.last_activ = DateTime.now
    
    if request.user_agent != nil
      @user.device_type = request.user_agent
    else
      @user.device_type = "Console"
    end
    
    if @user.save
      log_in @user
      # flash[:success] = "Willkommen bei qUos"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def delete_picture
     @user = User.find(params[:id])
     @user.remove_picture!
     @user.save
     redirect_to request.referrer || root_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil aktualisiert"
    end
    
    ajax = params[:ajax]
    if ajax
      render :nothing => true
    else
      redirect_to request.referrer || root_url    
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:last_activ, :firstname, :email, :password,
                                   :password_confirmation, :display_name, :picture)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Bitte anmelden."
        redirect_to login_url
      end
    end
    
     # Confirms the correct user or admin.
    def correct_user
      @user = User.find(params[:id])
      
      
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end