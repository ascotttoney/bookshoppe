class Book < ApplicationRecord
  belongs_to :author
  has_many :user_books
  has_many :trade_books, through: :user_books
  has_many :users, through: :user_books

  validates :title, { presence: true }
  before_save { self.title = self.title.downcase }

  def slug
    "\"#{self.title.titleize}\" by #{self.author.name.titleize}"
  end

  def users_with_available_ub
    self.user_books.select { |ub| ub.available? }.map(&:user).uniq
  end
end
