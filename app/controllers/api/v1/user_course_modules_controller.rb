class Api::V1::UserCourseModulesController < Api::V1::BaseController
  def index
    @user_course_modules = policy_scope(UserCourseModule)
  end

  def show
    @user_course_module = UserCourseModule.find(params[:user_course_module_id])
    authorize @user_course_module
  end

  def create
    @user_course_module = UserCourseModule.new(user_course_module_params)
    authorize @user_course_module
    @user_course_module.user = @user
    @user_course_module.save
    if @user_course_module.persisted?
      render :create
    else
      render_error(@user_course_module)
    end
  end

  private

  def user_course_module_params
    params.permit(:course_module_id)
  end
end
