class Game < ApplicationRecord
    belongs_to :league
    has_many :bets
    has_many :comments 
    has_many :team_events
    has_many :likes
    has_many :replies, through: :comments
    has_many :users, through: :bets
    has_many :teams, through: :team_events
    validates :date, :time, :presence => true
    attr_accessor :team_1, :team_2, :ninety_minutes
    validates_with ValidateGameTeams


    
    def comments_by_date()
        self.comments.reverse{|comment|
            comment.created_at
        }
    end

    def self.upcoming_games()
        Game.all.select{|game|
        game.date >= Date.today
    }
    end

    def self.time_zone(t)
        Time.parse(t)   
    end

    def self.date(d)
       Date.parse(d)
    end

    def time=(time)
      if !time.empty? 
        write_attribute(:time, Time.parse(time))
        # self[:time] = Time.parse(time)  
      end
    end

    def game_date
        self.date === Date.today
    end

    def self.ninety_minutes
        today_games = Game.all.select{|g| g.date === Date.today}
        today_games.each{|game|
            game_start = Time.parse(game.time.localtime.strftime("%H:%M"))
            game_finish = game_start + 110.minutes
            now  = Time.now

            if  now < game_start  && game.status != "PENDING"
                game.status != "PENDING"
                game.status =  "PENDING"
                game.save
            elsif  now > game_finish && game.status != "FINISH"
                   game.status = "FINISH"
                   game.save    
            elsif now > game_start && now < game_finish && game.status != "LIVE"
                   game.status = "LIVE"
                   game.save
            end
        }
    end

    def game_bets
      loser =  self.team_events.find_by(points: 0) 
      winner = self.team_events.find_by(points: 3) 
      tie = self.bets.find_by(team_id: nil) 
      if !self.bets.empty?
        total = self.bets.reduce(0){|s,n| n.amount + s}
      end

      if winner && !self.bets.empty?
        winner_bets = self.bets.select{|b|b.team === winner.team }
        total_winner_teams = winner_bets.reduce(0){|s,n| n.amount + s}
        if total_winner_teams > 0
          pay_per_dolar = total / total_winner_teams 
          winner_bets.each{|b|
            b.user.coins = b.user.coins + (pay_per_dolar * b.amount)
            b.user.save
          }
        end
      end

      if loser && !self.bets.empty?
        loser_bets = self.bets.select{|b|b.team === loser.team }
        total_loser_teams = loser_bets.reduce(0){|s,n| n.amount + s}
        
      end
      if tie && !self.bets.empty?
        tie_bets = self.bets.select{|b|b.team === tie.team }
        total_tie = tie_bets.reduce(0){|s,n| n.amount + s}
        if total_tie > 0
            dolar_per_tie = total / total_tie
            tie_bets.each{|b|
               b.user.coins = b.user.coins + (dolar_per_tie * b.amount)
               b.user.save
            }
        end
      end 
    end


    def save_teams(team_1,team_2)
        team_1_event = TeamEvent.new
        team_1_event.team = team_1
        team_1_event.game = self
        team_1_event.save
       
        team_2_event = TeamEvent.new
        team_2_event.team = team_2
        team_2_event.game = self
        team_2_event.save
    end

end

