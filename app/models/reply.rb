class Reply < ApplicationRecord
    belongs_to :game , optional: true
    belongs_to :comment, optional: true
    has_many :likes
    belongs_to :user, optional: true
    has_many :images
end
