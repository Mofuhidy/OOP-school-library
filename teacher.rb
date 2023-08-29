require_relative 'person'

class Teacher < Person
   attr_accessor :type
   
  def initialize(age, specialization, name = 'Unknown', parent_permission)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
    @type = 'Teacher'
  end

  def can_use_services?
    true
  end
end
