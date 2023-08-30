require_relative 'nameable'
require_relative 'rental'

class Person < Nameable
  # getters
  attr_reader :id, :rentals

  # setters
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = generate_id
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  private

  def of_age?
    @age && @age >= 18
  end

  def generate_id
    rand(1..1000)
  end
end
