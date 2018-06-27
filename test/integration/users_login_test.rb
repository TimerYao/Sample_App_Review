require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end


  test "invalid log in" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params:{
      session:{
        email: 'sss',
        password: '22'
      }
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
    
    get root_path
    assert flash.empty?
  end

  test 'valid log in' do
    get login_path
    post login_path, params:{
      session:{
        email: @user.email,
        password: 'password'
      }
    }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

  end

end
