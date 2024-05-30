class Bet < ApplicationRecord
    belongs_to :user
    belongs_to :game
    belongs_to :team, optional: true
end
