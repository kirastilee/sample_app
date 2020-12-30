class User< ApplicationRecord
    validates :name, presence: true, length: { maximum:50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { minimum: 6},
                        format: {with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false}
    validates :password, presence: true, length: {minimum: 6 }

    before_save :email_downcase

    has_secure_password

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    private
    def email_downcase
        email.downcase!
    end
end
