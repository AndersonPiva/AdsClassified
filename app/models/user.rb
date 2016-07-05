class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  has_attached_file :image, styles: { :medium => "50x50>", :tiny => "30x30" }, default_url: ("/img/missing.png")
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  belongs_to :city
  has_many :advertisements, :dependent => :destroy
  has_many :favourites, :dependent => :destroy
  has_one :evaluator, :dependent => :destroy
  has_one :rated, :dependent => :destroy
  has_one :sender, :dependent => :destroy
  has_one :receiver, :dependent => :destroy

  acts_as_follower
  acts_as_followable
  searchkick autocomplete: ['name']

  def self.from_omniauth(auth)
    if user = User.find_by_uid(auth.uid)
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      avatar_url = process_uri(auth.info.image)
      user.image = URI.parse(avatar_url)
      return user
    else
      user = User.new
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.username = auth.info.email.split("@").first
      user.password = Devise.friendly_token[0,20]
      avatar_url = process_uri(auth.info.image)
      user.image = URI.parse(avatar_url)
      user.kind = "Pessoal"
      user.skip_confirmation!
      user.save
      evaluator = Evaluator.new user_id: user.id
      evaluator.save
      rated = Rated.new user_id: user.id
      rated.save
      sender = Sender.new user_id: user.id
      sender.save
      receiver = Receiver.new user_id: user.id
      receiver.save
      return user
    end
  end

  def self.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end

  def skip_confirmation!
    self.confirmed_at = Time.current
  end

  def to_param
      "#{id}-#{username.parameterize}"
  end
end
