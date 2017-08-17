module V1
  class LetterApi < Grape::API
    version 'v1'
    format :json
    rescue_from :all

    helpers do
      def letter
        Letter.find(params[:id])
      end
    end

    resource :letters do
      #api/v1/letters
      desc I18n.t(:return_letters)
      get do
        Letter.all
      end

      #api/v1/letters/:id
      desc I18n.t(:return_letter)
      params do
        requires :id, type: Integer, desc: I18n.t(:letter_id)
      end
      get ':id' do
        letter
      end

      desc I18n.t(:change_status)
      params do
        requires :mail_status, type: String
      end
      put ':id/states' do
        available_states = letter.aasm.states(:permitted => true).map(&:name)
        letter.update(declared(params)) if available_states.include?(params[:mail_status].to_sym)
        letter
      end

      desc I18n.t(:create_letter)
      params do
        requires :url, type: String, desc: I18n.t(:url)
        requires :email, type: String, desc: I18n.t(:email)
        requires :comment, type: String, desc: I18n.t(:comment)
      end
      post do
        letter = Letter.new(declared(params))
        letter.user_id = 1
        letter if letter.save
      end

      desc I18n.t(:update_letter)
      params do
        requires :url, type: String, desc: I18n.t(:url)
        requires :email, type: String, desc: I18n.t(:email)
        requires :comment, type: String, desc: I18n.t(:comment)
      end
      put ':id' do
        letter if letter.update(declared(params))
      end      
    end
  end
end
