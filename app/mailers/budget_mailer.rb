class BudgetMailer < ApplicationMailer

  def budget_alert
    @user = params[:user]
    @budget = params[:budget]
    mail(to: @user.email, subject: 'Limite do budget perto de ser alcançado')
  end

  def budget_exceeded_alert
    @user = params[:user]
    @budget = params[:budget]
    mail(to: @user.email, subject: 'Limite do budget alcançado')
  end
end
