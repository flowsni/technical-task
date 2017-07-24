class LettersController < ApplicationController
  def show
    @user = current_user
    @letters = @user.letters
  end
end
