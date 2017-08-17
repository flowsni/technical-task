module V1
  class SomeApi < Grape::API
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
      desc 'Return letters'
      get do
        Letter.all
      end

      #api/v1/letters/:id
      desc 'Return letter'
      params do
        requires :id, type: Integer, desc: 'letter id'
      end
      get ':id' do
        letter
      end

      desc 'Change mail status'
      params do
        requires :mail_status, type: String
      end
      put ':id/states' do
        available_states = letter.aasm.states(:permitted => true).
          map(&:name)
        if available_states.include?(params[:mail_status].to_sym)
          letter.update(declared(params))
        end
        letter
      end

      desc 'Create letter'
      params do
        requires :url, type: String, desc: 'URL'
        requires :email, type: String, desc: 'Email'
        requires :comment, type: String, desc: 'Comment'
      end
      post do
        letter = Letter.new(declared(params))
        letter.user_id = 1
        letter if letter.save
      end

      desc 'Update letter'
      params do
        requires :url, type: String, desc: 'URL'
        requires :email, type: String, desc: 'Email'
        requires :comment, type: String, desc: 'Comment'
      end
      put ':id' do
        letter if letter.update(declared(params))
      end      
    end
  end
end
