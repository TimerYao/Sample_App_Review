class Help < ApplicationRecord
    validates :title, presence: true, length: { maximum: 50 }
    validates :mobile, presence: true, length: { maximum: 11 }
    validates :content, presence: true, length: { maximum: 255 }
end
