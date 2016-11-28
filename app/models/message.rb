class Message < ActiveRecord::Base
  belongs_to :receiver
  belongs_to :sender

  searchkick
end
