# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_30_020359) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'authors', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'books', force: :cascade do |t|
    t.string 'title'
    t.integer 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['author_id'], name: 'index_books_on_author_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'trade_id'
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['trade_id'], name: 'index_comments_on_trade_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'trade_books', force: :cascade do |t|
    t.integer 'trade_id'
    t.integer 'user_book_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['trade_id'], name: 'index_trade_books_on_trade_id'
    t.index ['user_book_id'], name: 'index_trade_books_on_user_book_id'
  end

  create_table 'trades', force: :cascade do |t|
    t.integer 'sender_id'
    t.integer 'recipient_id'
    t.string 'status'
    t.boolean 'sender_complete', default: false
    t.boolean 'recipient_complete', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['recipient_id'], name: 'index_trades_on_recipient_id'
    t.index ['sender_id'], name: 'index_trades_on_sender_id'
  end

  create_table 'user_books', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'book_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['book_id'], name: 'index_user_books_on_book_id'
    t.index ['user_id'], name: 'index_user_books_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'username'
    t.string 'login_name'
    t.string 'email'
    t.string 'phone_number'
    t.string 'address'
    t.string 'avatar'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
