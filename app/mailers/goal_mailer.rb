class GoalMailer < ApplicationMailer

  def goal_achieved
    @user = params[:user]
    @goal = params[:goal]
    mail(to: @user.email, subject: 'Goal Concluído')
  end

  def goal_failed
    @user = params[:user]
    @goal = params[:goal]
    mail(to: @user.email, subject: 'Goal Falhado')
  end

  def goal_started
    @user = params[:user]
    @goal = params[:goal]
    mail(to: @user.email, subject: 'Goal Iniciado')
  end
end
