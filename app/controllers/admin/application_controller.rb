class Admin::ApplicationController < ApplicationController

  layout 'mazer'

  def policy_scope(scope)
    super([:admin, scope])
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end

  def pundit_user
    current_admin
  end

end
