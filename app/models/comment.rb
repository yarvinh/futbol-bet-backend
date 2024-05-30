class Comment < ApplicationRecord
    belongs_to :game
    belongs_to :user, optional: true
    has_many :replies
    has_many :likes

    def replies_by_date()
        self.replies.reverse{|reply|
            reply.created_at
    
        }
    end
end
