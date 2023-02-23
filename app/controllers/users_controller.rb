class UsersController < ApplicationController

  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week

    @chart_data = [
      ['6日前', @books.created_6days_ago.count],
      ['5日前', @books.created_5days_ago.count],
      ['4日前', @books.created_4days_ago.count],
      ['3日前', @books.created_3days_ago.count],
      ['2日前', @books.created_2days_ago.count],
      ['1日前', @yesterday_book.count],
      ['今日', @today_book.count]
    ]

  end

  def index

    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render 'edit'
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
