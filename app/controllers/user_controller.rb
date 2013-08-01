class UserController < AuthController
  def add_balance
    current_user.add_balance(1000)
    redirect_to root_path
  end
end
