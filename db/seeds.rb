# PremierLeague.each{|e| Team.create(e)}
# LaLiga.each{|e| Team.create(e)}
# SerieA.each{|e| Team.create(e)} 
# Bundesliga.each{|e| Team.create(e)}  
# LigueOne.each{|e| Team.create(e)} 



# User.create(name: 'Soccer Bets',username: 'admin',password: '12345',email:"admin@gmail.com",coins: 1000000, address: '114 116th street',admin: true)






teams = [{
        fc: "Athletic Club",
        league: nil,
        stadium: "Estadio San Mamés",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/xsmall/athletic.png"
    },
    {
        fc: "Atletico de Madrid",
        league: nil,
        stadium: "Civitas Metropolitano",
        logo_url: "https://assets.laliga.com/assets/2024/06/17/xsmall/cbc5c8cc8c3e8abd0e175c00ee53b723.png"
    },
    {
        fc: "Osasuna",
        league: nil,
        stadium: "Estadio El Sadar",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/xsmall/osasuna.png"
    },
    {
        fc: "Leganés",
        league: nil,
        stadium: "Estadio Municipal Butarque",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/xsmall/leganes.png"
    },
    {
        fc: "Alavés",
        league: nil,
        stadium: "Mendizorroza",
        logo_url: "https://assets.laliga.com/assets/2020/09/01/xsmall/27002754a98bf535807fe49a24cc63ea.png",

    },
    {
        fc: "Barcelona",
        league: nil,
        stadium: "Estadi Olímpic Lluís Companys",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/xsmall/barcelona.png"
    },
    {
        fc: "Getafe",
        league: nil,
        stadium: "Coliseum",
        logo_url:"https://assets.laliga.com/assets/2023/05/12/small/dc59645c96bc2c9010341c16dd6d4bfa.png"
    },
    {
        fc: "Girona",
        league: nil,
        stadium: "Estadio Municipal de Montilivi",
        logo_url:"https://assets.laliga.com/assets/2022/06/22/small/8f43addbb29e4a72f5e90b6edfe4728f.png"
    },
    {
        fc: "Rayo Vallecano",
        league: nil,
        stadium: "Estadio de Vallecas",
        logo_url:"https://assets.laliga.com/assets/2023/04/27/small/57d9950a8745ead226c04d37235c0786.png",
    },
    {
        fc: "Celta de Vigo",
        league: nil,
        stadium: "1923  Estadio ABANCA Balaídos",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/small/celta.png"
    },
    {
        fc: "Espanyol ",
        league: nil,
        stadium: "RCDE Stadium",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/small/espanyol.png"
    },
    {
        fc: "Mallorca",
        league: nil,
        stadium: "Estadi Mallorca Son Moix",
        logo_url:"https://assets.laliga.com/assets/2023/03/22/small/013ae97735bc8e519dcf30f6826168ca.png"
    },
    {
        fc: "Real Betis",
        league: nil,
        stadium: "Estadio Benito Villamarín",
        logo_url:"https://assets.laliga.com/assets/2022/09/15/small/e4a09419d3bd115b8f3dab73d480e146.png"
    },
    {
        fc: "Real Madrid",
        league: nil,
        stadium: "Estadio Santiago Bernabéu",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/small/real-madrid.png"
    },
    {
        fc: "Real Sociedad",
        league: nil,
        stadium: "Reale Arena",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/small/real-sociedad.png"
    },
    {
        fc: "Valladolid",
        league: nil,
        stadium: "Municipal José Zorrilla",
        logo_url:"https://assets.laliga.com/assets/2024/06/17/small/1467dcd5efb813a742d86f8eb39504a3.png"
    },
    {
        fc: "Sevilla",
        league: nil,
        stadium: "Ramón Sánchez-Pizjuán",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/small/sevilla.png"
    },
    {
        fc: "Las Palmas",
        league: nil,
        stadium: "Estadio Gran Canaria",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/small/las-palmas.png"
    },
    {
        fc: "Valencia",
        league: nil,
        stadium: "Camp de Mestalla",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/small/valencia.png"
    },
    {
        fc: "Villarreal",
        league: nil,
        stadium: "Estadio de la Cerámica",
        logo_url: "https://assets.laliga.com/assets/2019/06/07/small/villarreal.png"
    }
]


teams.each{|team|
  Team.create(team)
}