require_relative 'person'

class Student < Person
  attr_reader :classroom
  attr_accessor :type

  def initialize(age, name, parent_permission)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    @type = 'Student'
  end

  def play_hooky
    ' ̄(ツ)/ ̄'
  end

  # setter
  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
