json.array! @user_course_modules do |user_course_module|
  course_module = user_course_module.course_module

  json.user_course_module do
    json.id user_course_module.id
    json.name course_module.name
    json.description course_module.description
    json.course_id course_module.id
    json.course_length course_module.courses.size
  end
end
