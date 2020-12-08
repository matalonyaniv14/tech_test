class UserCourseModule < ApplicationRecord
  belongs_to :user
  belongs_to :course_module
end
