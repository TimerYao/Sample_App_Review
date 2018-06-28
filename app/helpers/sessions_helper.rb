module SessionsHelper

    # 登录指定用户
    def log_in(user)
        session[:user_id] = user.id
    end

    #  记住用户
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # 返回当前用户
    def current_user
        if (user_id = session[:user_id])
            @current_user ||=User.find_by(id: user_id)
        else (user_id = cookies.signed[:user_id])
            user = User.find_by(id:user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end  
        end
        
    end
    # 判断是否登录

    def logged_in?
        !current_user.nil?
    end

    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # 退出
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    # 判断是否是当前用户 ，是的话就返回true
    def current_user?(user)
        user == current_user
    end
    

    # 重定向到默认地址或者存储地址
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url) 
    end
    # 存储要转向的地址
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
end
