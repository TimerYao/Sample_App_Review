require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path #访问注册页面
    assert_no_difference 'User.count' do
      post users_path, params: { user: {
          name: "",
          email:"user@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  # 注册成功测试
  test "valid signup information" do
    get signup_path #访问注册页面
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
          name: "Example User",
          email:"user@example.com",
          password: "foobar",
          password_confirmation: "foobar"
        }
      }
    end
    follow_redirect! # 跟踪重定向
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end

end
