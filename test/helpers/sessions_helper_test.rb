# 1. 使用固件定义一个 user 变量；
# 2. 调用 remember 方法记住这个用户；
# 3. 确认 current_user 就是这个用户。

require 'test_helper'
    class SessionsHelperTest < ActionView::TestCase

    def setup
        @user = users(:michael)
        remember(@user)
    end

    test "current_user returns right user when session is nil" do
        assert_equal @user, current_user
        assert is_logged_in?
    end

    test "current_user returns nil when remember digest is wrong" do
        @user.update_attribute(:remember_digest, User.digest(User.new_token))
        assert_nil current_user
    end
end