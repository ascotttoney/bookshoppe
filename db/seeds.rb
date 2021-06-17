User.destroy_all
UserBook.destroy_all
TradeBook.destroy_all
Trade.destroy_all
require_relative 'book_seeds' if Book.all.empty? && Author.all.empty?

User
  .create(
	first_name: 'Andrew',
	last_name: 'Allen',
	username: 'ASAllen67',
	email: '2@2.w',
	password: '123',
	phone_number: '1234567890',
	address: '900 Parsons Drive'
  )
  .user_books
  .create(book: Book.second)
User.create(
  first_name: 'Jaehyun',
  last_name: 'Park',
  username: 'AC2CIC',
  email: 'jae@test.com',
  password: '123',
  phone_number: '5551234567',
  address: '567 Roundtree Park'
).user_books << [
  UserBook.create(book: Book.third),
  UserBook.create(book: Book.third),
  UserBook.create(book: Book.last)
]
scott =
  User.create(
	first_name: 'Scott',
	last_name: 'Toney',
	username: 'batcat84',
	email: 'scott@test.com',
	password: '123',
	phone_number: '5556782222',
	address: 'West End Atlanta',
	avatar: 'https://i.imgur.com/ha97zfB.jpg'
  )

Book.all.each { |book| scott.user_books << UserBook.create(book: book) }

Trade.create(sender: User.all[1], recipient: User.all[0], status: 'pending')
  .trade_books << [
  TradeBook.create(user_book: UserBook.all[0]),
  TradeBook.create(user_book: UserBook.all[1]),
  TradeBook.create(user_book: UserBook.all[2])
]

Comment.create(trade: Trade.first, user: User.first, content: 'Hello world.')
Comment.create(trade: Trade.first, user: User.all[1], content: 'I am Jae.')
