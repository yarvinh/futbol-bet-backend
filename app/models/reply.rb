class Reply < ApplicationRecord
    belongs_to :game , optional: true
    belongs_to :comment, optional: true
    has_many :likes
    belongs_to :user, optional: true
    has_many :images
    def create_images(images,user_id)
        images.each{|img|
           self.images.create({image: img, user_id: user_id})
        }
    end
end
