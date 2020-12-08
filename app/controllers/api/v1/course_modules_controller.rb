class Api::V1::CourseModulesController < Api::V1::BaseController
  def index
    @course_modules = policy_scope(CourseModule)
  end

  def show
    @course_module = CourseModule.find(params[:course_module_id])
    authorize @course_module
  end
end
