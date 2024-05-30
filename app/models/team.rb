class Team < ApplicationRecord
    belongs_to :game , optional: true
    # belongs_to :bet , optional: true
    has_many :bets
    has_many :team_events
    has_many :games, through: :team_events
end
