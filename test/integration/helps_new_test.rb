require 'test_helper'

class HelpsNewTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get helpup_path #访问help new页面
    assert_no_difference 'Help.count' do
      post helps_path, params: { help: {
          title: "",
          mobile:"152",
          content: "这是问题详情"
        }
      }
    end
    assert_template 'helps/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  # 提问成功测试
  test "valid signup information" do
    get helpup_path #访问注册页面
    assert_difference 'Help.count', 1 do
      post helps_path, params: { help: {
          title: "ruby当前版本",
          mobile:"15201178939",
          content: "这是问题详情"
        }
      }
    end
    follow_redirect! # 跟踪重定向
    assert_template 'helps/index'
    assert_not flash.empty?
  end
end
