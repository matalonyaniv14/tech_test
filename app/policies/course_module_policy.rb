class CourseModulePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.professional_member?
        scope.all
      elsif @user.premium_member?
        scope.where.not(subscription_type: User::SUBSCRIPTION_TYPES[:professional])
      else
        scope.where(subscription_type: User::SUBSCRIPTION_TYPES[:basic])
      end
    end
  end

  def show?
    @user.allowed_plans.include?(@record.subscription_type)
  end
end
