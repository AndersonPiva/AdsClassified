class Advertisement < ActiveRecord::Base
  belongs_to :user
  has_many :favourites
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => :all_blank, :allow_destroy => true
  searchkick autocomplete: ['title']

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
