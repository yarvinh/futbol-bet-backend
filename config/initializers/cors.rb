Rails.application.config.middleware.insert_before 0, Rack::Cors do

    allow do
     origins 'https://work-orders-frontend-e69a673b70ee.herokuapp.com','http://localhost:3001',"https://www.maintainmagic.com"
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end
  end
 