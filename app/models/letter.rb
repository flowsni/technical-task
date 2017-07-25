class Letter < ActiveRecord::Base
  belongs_to :user
  include AASM
  
  aasm do
    state :new, :initial => true
    state :active, :ended

    event :new_to_active do
      transitions :from => :new, :to => :active
    end

    event :new_to_ended do
      transitions :from => :new, :to => :ended
    end

    event :active_to_ended do
      transitions :from => :active, :to => :ended
    end
  end

  def to_s
    email
  end
end
