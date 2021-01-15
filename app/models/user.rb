class User< ApplicationRecord
    attr_accessor :remember_token

    has_one_attached :image

    has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:
                                    :destroy
    
    has_many :passive_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:
                                    :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

    validates :name, presence: true, length: { maximum:50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { minimum: 6},
                        format: {with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false}
    validates :password, presence: true, length: {minimum: 6 }, allow_nil: true

    before_save :email_downcase

    has_secure_password

    has_many :microposts, dependent: :destroy

    class << self
      def digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end
    
      def new_token
        SecureRandom.urlsafe_base64
      end
    end

    def remember
      self.remember_token =User.new_token
      update_attributes(remember_digest: User.digest(remember_token))
    end

    def authenticated?(remember_token)
      BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
    end
    
    def forget
      update_attributes(remember_digest: nil)
    end

    def feed
      microposts
    end 

    def display_image
      image.variant(resize_to_limit: [500, 500])
    end

    def follow(other_user)
      following << other_user
    end

    def unfollow(other_user)
      following.delete(other_user)
    end

    def following?(other_user)
      following.include?(other_user)
    end

    private
    def email_downcase
      email.downcase!
    end
end
