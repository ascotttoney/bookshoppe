Author.create(name: 'Czeslaw Milosz').books.create(title: 'Unattainable Earth')

20.times do
  author = Author.create(name: Faker::Book.author)
  rand(4).times { author.books.create(title: Faker::Book.title) }
end
