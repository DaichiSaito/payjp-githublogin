class SessionsController < ApplicationController
  def new
  end

  def destroy
    logout
    redirect_to login_path, notice: 'ログアウトしました'
  end
end
