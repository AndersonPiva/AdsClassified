class Evaluator < ActiveRecord::Base
  belongs_to :user
  has_many :evaluations, :dependent => :destroy
end
