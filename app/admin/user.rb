ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model, :email, 
    :password, :password_confirmation
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

index do |f|
  f.column :id
  f.column :email
  f.column :created_at
  f.actions do |user|
    link_to t(:send_message), new_message_admin_user_path(user)
  end
end

form do |f|
  f.inputs "Create User" do
    f.input :email
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end

member_action :new_message, :method => :get do
  @user = User.find_by(id: params[:id])
  redirect_to admin_users_path unless @user
end

member_action :send_message, :method => :post do
  @user = User.find_by(id: params[:id])
  redirect_to admin_users_path unless @user
  UserMailer.send_message(@user, params[:message]).deliver_later
  redirect_to admin_users_path
end

end
