class LettersController < ApplicationController
  def index
  end

  def edit
    @letter = current_user.letters.find_by(id: params[:id])
    if @letter.nil?
      redirect_to root_path
      flash[:notice] = "Error"
    else  
      @aasm_states = @letter.aasm.states(permitted: true).map { |status| [status.name, status.name] } << [@letter.aasm.current_state, @letter.aasm.current_state]  
    end
  end

  def update
    @letter = current_user.letters.find_by(id: params[:id])
    if @letter.update_attributes(params.require(:letter).permit(:comment, :mail_status))
      redirect_to root_path
    else
      render 'edit'
    end
  end

end
