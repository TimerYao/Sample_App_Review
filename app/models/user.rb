class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship",
              foreign_key: "follower_id",
              dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed

    has_many :passive_relationships, class_name: "Relationship",
             foreign_key: "followed_id",
             dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower

    # before_save { self.email = email.downcase }
    attr_accessor :remember_token # 创建属性
    before_save {  email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX }, 
            uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6}, allow_nil: true
    has_secure_password

    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                BCrypt::Engine.cost
                BCrypt::Password.create(string, cost:cost)
    end

    # 返回一个随机令牌
    def self.new_token
        SecureRandom.urlsafe_base64
    end

    # 为了保存会话，在数据中记住用户
    def remember
        self.remember_token = User.new_token
        # 将得到的随机令牌赋值给用户的remember_token属性
        update_attribute(:remember_digest, User.digest(remember_token))
        # 使用User.digest生成新的摘要。，更新数据库记忆摘要
    end

    # 比较指定令牌和摘要，匹配则返回true
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # 忘记用户
    def forget
        update_attribute(:remember_digest, nil)
        #   清空记忆摘要
    end
    # 实现动态流原型
    def feed
        # Micropost.where("user_id = ?", id)
        # Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
        following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
                    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
    end

    # 关注另一个用户
    def follow(other_user)
        following << other_user
    end
    # 取消关注另一个用户
    def unfollow(other_user)
        following.delete(other_user)
    end
    # 如果当前用户关注了指定的用户，返回 true
    def following?(other_user)
        following.include?(other_user)
    end
end
