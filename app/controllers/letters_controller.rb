class LettersController < ApplicationController
  def index
    @user = current_user
    @letters = @user.letters
  end

  def show
  end

  def edit
    @user = current_user
    @letters = Letter.all
    @letter = @user.letters.find(params[:id])
    @aasm_states = Letter.aasm.states.map(&:name)
  end

  def update
    @user= current_user
    @letter = @user.letters.find(params[:id])
    if @letter.update_attributes(params.require(:letter).permit(:comment, :mail_status))
      redirect_to root_path
    else
      render 'edit'
    end
  end

end
