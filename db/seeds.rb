# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Course.destroy_all
UserCourseModule.destroy_all
CourseModule.destroy_all
User.destroy_all

User::SUBSCRIPTION_TYPES.values.each do |type|
  user = {
    email: "goo0o0o0o0oodEmail@aol.com" + type,
    password: "123456",
    subscription_type: type,
  }

  course_module = {
    name: "finance " + type,
    description: "learn about finance " + type,
    subscription_type: type,
  }
  puts type
  p user = User.create!(user)
  p course_module = CourseModule.create!(course_module)
  p video_course = VideoCourse.create!({
    name: "finance course 1",
    description: "part 1 of financial course",
    video_url: "http://somevideo.com",
    course_module: course_module,
  })
  p UserCourseModule.create!({
    user: user,
    course_module: course_module,
  })
end
