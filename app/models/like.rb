class Like < ApplicationRecord
    belongs_to :game, optional: true
    belongs_to :user
    belongs_to :comment, optional: true
    belongs_to :reply, optional: true
end
