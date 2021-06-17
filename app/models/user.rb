class User < ApplicationRecord
  has_many :user_books
  has_many :trade_books, through: :user_books
  has_many :books, through: :user_books
  has_many :comments, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  has_secure_password

  EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  PHONE_REGEX = /\A\d{10}\z/
  USERNAME_REGEX = /\A[a-zA-Z0-9_]*\z/i

  validates :first_name, { presence: true, length: { maximum: 50 } }
  validates :last_name, { presence: true, length: { maximum: 50 } }
  validates :username,
            {
              presence: true,
              format: {
                with: USERNAME_REGEX
              },
              uniqueness: {
                case_sensitive: false
              }
            }
  validates :email,
            {
              presence: true,
              format: {
                with: EMAIL_REGEX
              },
              uniqueness: {
                case_sensitive: false
              },
              length: {
                maximum: 50
              }
            }
  validates :phone_number,
            { presence: true, format: { with: PHONE_REGEX }, uniqueness: true }

  validates :password, { length: { minimum: 3 }, allow_blank: true }

  before_save do
    [
      self.first_name = self.first_name.capitalize,
      self.last_name = self.last_name.capitalize,
      self.login_name = self.username.downcase,
      self.email = self.email.downcase
    ]
  end

  def full_name
    [self.first_name, ' ', self.last_name].join
  end

  def all_trades
    Trade.all.select { |t| t.sender == self || t.recipient == self }
  end

  def inc_trades
    Trade.all.select { |t| t.recipient == self && t.status == 'pending' }
  end

  def out_trades
    Trade.all.select { |t| t.sender == self && t.status == 'pending' }
  end

  def accepted_trades
    Trade.all.select do |t|
      (t.sender == self || t.recipient == self) && t.status == 'accepted'
    end
  end

  def completed_trades
    Trade.all.select do |t|
      (t.sender == self || t.recipient == self) && t.status == 'completed'
    end
  end

  # original - no longer used
  #
  # def inventory
  #   inv = {}
  #   self.books.each { |book|
  #     inv[book.slug] ||= 0
  #     inv[book.slug]  += 1
  #   }
  #   return inv
  # end

  # now only returns UserBooks that are available
  def inventory
    inv = {}
    self.user_books.select { |ub| ub.available? }.each do |ub|
      inv[ub.book.slug] ||= 0
      inv[ub.book.slug] += 1
    end
    return inv
  end

  def find_ub_by_slug(slug)
    self.user_books.select { |ub| ub.book.slug == slug }
  end
end
