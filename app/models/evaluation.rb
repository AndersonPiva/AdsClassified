class Evaluation < ActiveRecord::Base
  belongs_to :rated
  belongs_to :evaluator
end
