class LettersController < ApplicationController
  def index
    @letters = current_user.letters
    @aasm_states = Letter.aasm.states.map { |status| [status.name, status.name] } << ["all", "all"] 
    if params[:mail_status]
      @letters = @letters.where(:mail_status => params[:mail_status])
    end
    if params[:mail_status] == "all"
      redirect_to root_path
    end

    if params[:from] && params[:to]
      @letters = @letters.where(:created_at => params[:from]..params[:to])
    end


  end

  def edit
    @letter = current_user.letters.find_by(id: params[:id])
    if @letter.nil?
      redirect_to root_path
      flash[:notice] = t(:error)
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

  def filter_letter_by_status
  end

end
