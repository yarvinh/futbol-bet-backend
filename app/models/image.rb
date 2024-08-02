class Image < ApplicationRecord
    # belongs_to :game, optional: true
    has_one_attached :image 
    belongs_to :user
    belongs_to :comment, optional: true
    belongs_to :reply, optional: true

    def image_url
        Rails.application.routes.url_helpers.url_for(image)
     end
end
