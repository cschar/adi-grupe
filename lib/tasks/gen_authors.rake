
desc "gen some authors"
task gen_authors: :environment do
  puts "Genning books"
  5.times do |b|
    b = Book.create! title: FFaker::Book.title
  end

  puts "Genning authors"
  3.times do |n|
    a = Author.create! name: FFaker::Book.author
    Book.all.each do |b|
      puts
      a.books << b
      puts "created relation #{a.name} to book #{b.title}"
    end
  end

  puts "done:"
end