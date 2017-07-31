class LettersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @aasm_states = Letter.aasm.states.map { |status| [status.name, status.name] }  
    from_date = params[:from].blank? ? Letter.first.created_at : params[:from]
    to_date = params[:to].blank? ? DateTime.now : params[:to]
    @letters = current_user.letters
    @letters = @letters.where(:mail_status => params[:mail_status]) if params[:mail_status].present?
    @letters = @letters.where(created_at: from_date..to_date)
  end

  def edit
    @letter = current_user.letters.find_by(id: params[:id])
    if @letter.nil?
      redirect_to root_path
      flash[:notice] = t(:error)
    else  
      @aasm_states = @letter.aasm.states(permitted: true)
      .map { |status| [status.name, status.name] } << [@letter.aasm.current_state, @letter.aasm.current_state]  
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

  def search_letters
    if (params[:email]).present?
      @letter = Letter.all.where(:email => params[:email])
      if @letter.present?
        @user = @letter.first.user
        @status = @letter.first.mail_status 
      end
    else
      redirect_to root_path
    end    
  end

end
