module ApplicationHelper
     # 根据所在的页面返回完整的标题
     def full_title(page_title = '') # 定义方法，参数为字符串可为空
        base_title = "Ruby on Rails Tutorial Sample App" # 变量赋值
        if page_title.empty?  # 判断传入参数是否为空 布尔值
            base_title        # 返回 base_title
        else
            page_title + " | " + base_title   # 返回 base_title + 传递参数的 拼接字符串
        end
    end
end
