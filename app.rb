require_relative 'book'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    puts 'Welcome to School Library App!'
    menu
  end

  def menu
    loop do
      puts '' * 10
      puts 'Please choose an option by entering a number:'
      puts '1 - List all books'
      puts '2 - List all people'
      puts '3 - Create a person'
      puts '4 - Create a book'
      puts '5 - Create a rental'
      puts '6 - List all rentals for a given person id'
      puts '7 - Exit'
      print ''

      choice = gets.chomp.to_i

      case choice
      when 1..6 then options(choice)
      when 7 then puts 'Thank you for using our app.'
      end
      break if choice == 7
    end
  end

  def options(choice)
    case choice
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    end
  end

  def list_books
    if @books.empty?
      puts 'Sorry, No books available.'
    else
      @books.each do |book, index|
        puts "#{index} - Title: #{book.title}, Author: #{book.author}"
      end
    end
  end

  def list_people
    if @people.empty?
      puts 'Sorry, No people available.'
    else
      @people.each_with_index do |person, index|
        puts "#{index}- [#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = gets.chomp.to_i
    case type
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid option. Please enter a valid number: 1 or 2'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    person = Student.new(age, name, permission)
    @people.push(person)
    puts "Student '#{name}' created successfully"
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    person = Teacher.new(age, specialization, name)
    @people.push(person)
    puts "Teacher '#{name}' created successfully"
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts "Book '#{title}' created successfully"
  end

  def create_rental
    if @books.empty?
      puts 'Sorry, there is no book in the collection to rent out.'
    elsif @people.empty?
      puts 'Sorry, there is no person in the Database. Add a person first in the database'
    else
      puts 'Select a book from the following list by number'
      @books.each_with_index { |book, index| puts "#{index} - Title: #{book.title}, Author: #{book.author}" }
      book_index = gets.chomp.to_i
      book = @books[book_index]
      puts 'Select a person from the following list by number (not id)'
      @people.each_with_index do |person, index|
        puts "#{index} [#{person.type}] - Name: #{person.name}, Age: #{person.age}"
      end
      person_id = gets.chomp.to_i
      person = @people[person_id]
      print 'Date: '
      date = gets.chomp
      rental = Rental.new(date, person, book)
      @rentals.push(rental)
      puts "Rental for '#{book.title}' by '#{person.name}' created successfully"
    end
  end

  def list_rentals
    if @rentals.empty?
      puts 'Sorry, No rentals available.'
    else
      puts 'ID of person: '
      person_id = gets.chomp.to_i
      puts 'Rentals: '
      @rentals.each do |rental, _index|
        if person_id == rental.person.id
          puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
        end
      end
    end
  end
end
