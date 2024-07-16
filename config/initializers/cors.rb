Rails.application.config.middleware.insert_before 0, Rack::Cors do

    allow do
     origins 'http://localhost:3004','http://localhost:3001', 'http://localhost:3003', "http://10.0.0.6:3003"
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end
  end
 