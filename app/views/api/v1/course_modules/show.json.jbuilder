json.course_module do
  json.name @course_module.name
  json.description @course_module.description
  json.course_length @course_module.courses.size
end
