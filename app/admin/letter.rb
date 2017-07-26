ActiveAdmin.register Letter do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

permit_params :list, :of, :attributes, :on, :model, :url, :email, 
  :mail_status, :comment, :user_id


form do |f|
  f.inputs "" do
    f.input :user
    f.input :url
    f.input :email
    f.input :comment
    f.input :mail_status, input_html: { disabled: true }, label: 'Current state'
    f.input :mail_status, label: 'Change state', as: :select, collection: f.letter.aasm.states(permitted: true).map(&:name)
    actions
  end  
end

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
