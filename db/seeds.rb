PremierLeague.each{|e| Team.create(e)}
LaLiga.each{|e| Team.create(e)}
SerieA.each{|e| Team.create(e)} 
Bundesliga.each{|e| Team.create(e)}  
LigueOne.each{|e| Team.create(e)} 



User.create(name: 'Soccer Bets',username: 'admin',password: '12345',email:"admin@gmail.com",coins: 1000000, address: '114 116th street',admin: true)