class CourseModule < ApplicationRecord
  has_many :courses
  has_many :user_course_modules
  validate :allowed_subscription_types

  def allowed_subscription_types
    is_valid = User::SUBSCRIPTION_TYPES.values.include?(subscription_type)

    errors.add(:subscription_type,
               "invalid subscription type supplied") unless is_valid
  end
end
