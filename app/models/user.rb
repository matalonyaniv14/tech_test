class User < ApplicationRecord
  has_many :user_course_modules, as: :courses

  SUBSCRIPTION_TYPES = {
    basic: "basic",
    premium: "premium",
    professional: "professional",
  }

  validates :subscription_type, inclusion: {
                                  in: SUBSCRIPTION_TYPES.values,
                                  message: "'%{value}' is not a valid subscription",
                                }

  validates :email, uniqueness: true
  validates :token, uniqueness: true, allow_nil: true

  def premium_member?
    subscription_type == SUBSCRIPTION_TYPES[:premium]
  end

  def professional_member?
    subscription_type == SUBSCRIPTION_TYPES[:professional]
  end

  def basic_member?
    subscription_type == SUBSCRIPTION_TYPES[:basic]
  end

  def allowed_plans
    if professional_member?
      return SUBSCRIPTION_TYPES.values
    elsif premium_member?
      return SUBSCRIPTION_TYPES.values - [SUBSCRIPTION_TYPES[:professional]]
    else
      return [SUBSCRIPTION_TYPES[:basic]]
    end
  end
end
