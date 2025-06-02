class SessionsController < ApplicationController
  def new
    # Форма логіну (порожній метод — відобразить new.html.erb)
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Вітаємо, #{user.name}!"
    else
      flash.now[:alert] = "Неправильний email або пароль"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Ви вийшли з системи"
  end
end
