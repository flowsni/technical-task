class Letter < ActiveRecord::Base
  belongs_to :user

  def to_s
    id
  end
end
