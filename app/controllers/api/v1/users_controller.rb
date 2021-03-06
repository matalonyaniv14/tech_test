class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorize_request, only: [:new, :create]
  skip_before_action :set_current_user, only: [:new, :create]

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    @token = retrieve_token
    authorize @user
    @user.save
    if @user.persisted?
      render :create
    else
      render_error(@user)
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      render :create
    else
      render_error(@user)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :subscription_type)
  end
end

#  curl -X POST -H "Content-Type: application/json" -H "Authorization: bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkFkSjFmWTA2WlhUTlJoSW5DbGl3aSJ9.eyJpc3MiOiJodHRwczovL2Rldi15dG84aGVsOC5ldS5hdXRoMC5jb20vIiwic3ViIjoiSjdySG9qaTVXSHM4WklLM3RWR1FPRzUwUmlVNGhYV1lAY2xpZW50cyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCIsImlhdCI6MTYwNzQyMzYxMSwiZXhwIjoxNjA3NTEwMDExLCJhenAiOiJKN3JIb2ppNVdIczhaSUszdFZHUU9HNTBSaVU0aFhXWSIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyJ9.mnJZpfJHYAUbtOzC7ToSezZFmmks7TjrRFxf0utHxx3BXncNv0VcoHlHLYl5dujaiWtAF4rIixHzLGg2H9tB4X1GIOGpKLv2-kGoDybKjcewUcWOHHOzJU_XQk7gIYuQwPAFOuquiO80UGqX7XZkIDsCkM35snNyTUQN_7u72fvayr_7jwnrBfLcNCZwsCtpQ8EbHp7BQshcTYozFlfQQWbjAoXja8yHcXCOFVoX9BXb4bTyYg3V12jouJxdd1ifwWofCMRmHuhs-qNJVF2hQAm38Cjf6vqTt-ai5LKxgQMLxayppH4QxpaJX0czd2uSXLkLsBjbJObt9SatNBLZnA" -d '{"email":"cdosobc", "subscription_type":"premium"}' http://localhost:3000/api/v1/users
#  curl -X PUT -H "Content-Type: application/json" -H "Authorization: bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkFkSjFmWTA2WlhUTlJoSW5DbGl3aSJ9.eyJpc3MiOiJodHRwczovL2Rldi15dG84aGVsOC5ldS5hdXRoMC5jb20vIiwic3ViIjoiSjdySG9qaTVXSHM4WklLM3RWR1FPRzUwUmlVNGhYV1lAY2xpZW50cyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCIsImlhdCI6MTYwNzQyMTQzOSwiZXhwIjoxNjA3NTA3ODM5LCJhenAiOiJKN3JIb2ppNVdIczhaSUszdFZHUU9HNTBSaVU0aFhXWSIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyJ9.JPmZ8OFiiDYVhnJ63lk1vIKxWhOrLc-aRmn8yn34_H8-VYKE823Hh_CcbP56HseHdLJqG7-8O_tw4cicq2kTCwiJDjZkygxUbhCIweiAxUpubZqbIBZl2RQz_osjqJUQOie_5PFmrNqQhOMTMavA9gAoAaIldlstSYTidt_rC1-zpsOBud0MJulo6NRRfBQMs9mD5UnsrAGgALoo9F7Jj950Q1VrgoxG-UwvOJpWNZmAS1qzt3GervfSQYrNYl_C7ozr4DeqfgBuwxpLePyhpwqB3Xk3Tzwbg7jiYDDvbHCk2_R36E9hjrBn11ENG7l7BGa5bfNisKfHETtEUwemEQ" -d '{ "subscription_type":"premium"}' http://localhost:3000/api/v1/users/22
# curl  -H "Authorization: bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkFkSjFmWTA2WlhUTlJoSW5DbGl3aSJ9.eyJpc3MiOiJodHRwczovL2Rldi15dG84aGVsOC5ldS5hdXRoMC5jb20vIiwic3ViIjoiSjdySG9qaTVXSHM4WklLM3RWR1FPRzUwUmlVNGhYV1lAY2xpZW50cyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCIsImlhdCI6MTYwNzQyMTQzOSwiZXhwIjoxNjA3NTA3ODM5LCJhenAiOiJKN3JIb2ppNVdIczhaSUszdFZHUU9HNTBSaVU0aFhXWSIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyJ9.JPmZ8OFiiDYVhnJ63lk1vIKxWhOrLc-aRmn8yn34_H8-VYKE823Hh_CcbP56HseHdLJqG7-8O_tw4cicq2kTCwiJDjZkygxUbhCIweiAxUpubZqbIBZl2RQz_osjqJUQOie_5PFmrNqQhOMTMavA9gAoAaIldlstSYTidt_rC1-zpsOBud0MJulo6NRRfBQMs9mD5UnsrAGgALoo9F7Jj950Q1VrgoxG-UwvOJpWNZmAS1qzt3GervfSQYrNYl_C7ozr4DeqfgBuwxpLePyhpwqB3Xk3Tzwbg7jiYDDvbHCk2_R36E9hjrBn11ENG7l7BGa5bfNisKfHETtEUwemEQ" http://localhost:3000/api/v1/users/22/course_modules
# curl -X POST -H "Content-Type: application/json" -H "Authorization: bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkFkSjFmWTA2WlhUTlJoSW5DbGl3aSJ9.eyJpc3MiOiJodHRwczovL2Rldi15dG84aGVsOC5ldS5hdXRoMC5jb20vIiwic3ViIjoiSjdySG9qaTVXSHM4WklLM3RWR1FPRzUwUmlVNGhYV1lAY2xpZW50cyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCIsImlhdCI6MTYwNzQyMzYxMSwiZXhwIjoxNjA3NTEwMDExLCJhenAiOiJKN3JIb2ppNVdIczhaSUszdFZHUU9HNTBSaVU0aFhXWSIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyJ9.mnJZpfJHYAUbtOzC7ToSezZFmmks7TjrRFxf0utHxx3BXncNv0VcoHlHLYl5dujaiWtAF4rIixHzLGg2H9tB4X1GIOGpKLv2-kGoDybKjcewUcWOHHOzJU_XQk7gIYuQwPAFOuquiO80UGqX7XZkIDsCkM35snNyTUQN_7u72fvayr_7jwnrBfLcNCZwsCtpQ8EbHp7BQshcTYozFlfQQWbjAoXja8yHcXCOFVoX9BXb4bTyYg3V12jouJxdd1ifwWofCMRmHuhs-qNJVF2hQAm38Cjf6vqTt-ai5LKxgQMLxayppH4QxpaJX0czd2uSXLkLsBjbJObt9SatNBLZnA" -d '{"course_module_id":"10"}' http://localhost:3000/api/v1/users/27/user_course_modules
