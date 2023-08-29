require_relative 'nameable'

class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  # getters
  attr_reader :id

  # setters
  attr_accessor :name
  attr_accessor :age

  def can_use_services?
    of_age? || parent_permission
  end

  private

  def of_age?
    @age && @age >= 18
  end

  def generate_id
    rand(1..1000)
  end

  def correct_name
    @name
  end
end
