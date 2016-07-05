class Receiver < ActiveRecord::Base
  belongs_to :user
  has_many :messages, :dependent => :destroy
end
