class UserSerializer
    def initialize(user)
        @user = user
    end

    def to_serialized_json
        options = {
            include: {
                bets: {},
                image: {
                    only: [:user_id],
                    methods: :image_url
                }
            },
            except: [:password_digest, :updated_at, :created_at]   
        }
      
        @user.to_json(options)
    end

end