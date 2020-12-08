class Course < ApplicationRecord
  # self.abstract_class = true
  belongs_to :course_module
end
