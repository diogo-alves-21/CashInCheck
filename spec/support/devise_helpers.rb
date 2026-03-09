module DeviseHelpers
  def login(user, scope: :user)
    login_as(user, scope: scope)
  end
end
