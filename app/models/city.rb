class City < ActiveRecord::Base
  has_many :users

  def to_param
      "#{id}-#{name.parameterize}"
  end
end
