json.array! @course_modules do |course_module|
  json.name course_module.name
  json.description course_module.description
  json.course_length course_module.courses.size
  json.subscription_type course_module.subscription_type
end
