class UserCourseModulePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: @user)
    end
  end

  def show?
    @user.allowed_plans.include?(@record.course_module.subscription_type)
  end

  def create?
    show?
  end
end
