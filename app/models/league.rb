class League < ApplicationRecord
    has_many :tournaments
    has_many :teams, through: :tournaments
    validates :name, presence: true
end
