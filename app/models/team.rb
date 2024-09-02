class Team < ApplicationRecord
    belongs_to :game , optional: true
    # belongs_to :bet , optional: true
    has_many :bets
    has_many :team_events
    has_many :games, through: :team_events
    has_many :tournaments
    has_many :leagues, through: :tournaments
   

    validates :fc, :logo_url,  presence: true
    validates :fc, :logo_url, uniqueness: true

    def add_error(error)
        errors.add(:league, :blank, message: error)
      end
    

end
