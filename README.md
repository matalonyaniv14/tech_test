scope =>  '/api/v1'
auth_headers: {
    Authorization: basic <token>
}

Endpoints 

create a new user  => post =>  "/users"

body: {
    email: string
}

returns a "token" attribute to be used for the rest of the client calls.

-----------
update a user => put => "/users/:id"

body: {
    email: string,
    subscription_type: string<"basic" | "premium" | "professional">
}
-----------
get a list of course_modules => get => "/users/:id/course_modules"
show one course_module => get => "/users/:id/course_modules/:course_module_id"
-----------
list all user_course_modules => get => "/users/:id/user_course_modules"
show one user_course_module => get => "/users/:id/user_course_modules/:user_course_module_id"
-----------
create a new user_course_module => post => "/users/:id/user_course_modules"

body: {
    course_module_id: string
}
-----------



 get started
 1. rails db:create
 2. rails db:migrate
 3. rais db:seed

 I created 3 simple rake tasks so you can update more easily during testing

rails user:set_user_basic
rails user:set_user_premium
rails user:set_user_professional

 in terms of requesting an access token for client side auth
 request new auth token => "/request_session"
 response => {
     token: <token supplied by Auth0>
 }
