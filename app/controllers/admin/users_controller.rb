class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout 'mazer'

  def index
    @pagy, @users = pagy(User.order(created_at: :desc))
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts user_params
    respond_to do |format|
      if @user.save
        format.html { redirect_to [:admin, @user], notice: I18n.t('controllers.created', model: User.model_name.human(count: 1)) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit ;end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [:admin, @user], notice: I18n.t('controllers.updated', model: User.model_name.human(count: 1)) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy!
        format.html { redirect_to admin_users_url, notice: I18n.t('controllers.destroyed', model: User.model_name.human(count: 1)) }
      else
        format.html { redirect_to admin_users_url, alert: I18n.t('controllers.destroy_error', model: User.model_name.human(count: 1)) }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, member_attributes: [:name])
  end
end
