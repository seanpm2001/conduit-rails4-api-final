class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user

  scope :favorited_by, -> (username){ joins(:favorited_users).where(favorited_users: User.where(username: username)) }

  acts_as_taggable

  validates :title, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false
  validates :slug, uniqueness: true

  before_validation do
    self.slug = self.title.to_s.parameterize
  end
end
