class Comment < ApplicationRecord
    belongs_to :game
    belongs_to :user, optional: true
    has_many :replies
    has_many :likes
    has_many :images

    def replies_by_date()
        self.replies.reverse{|reply|
            reply.created_at
        }
    end

    def replies_total()
        self.replies.length
    end
end
