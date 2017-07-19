class Letter < ActiveRecord::Base
  include AASM

  aasm :column => '[mail_status]' do
  end

end
