class User < ApplicationRecord

    has_many :job_posts, dependent: :nullify

    # rails g model user first_name last_name email password_digest
    # 👆🏻used this terminal command to generate migration and model
    has_secure_password
    # 1. It provides authenication features on the model that is called in i.e. User
    # 2. REquirments for using has_secure_password 1. gem 'bcrypt', 2. password_digest as a column in a database
    # 3. I add presence validation to the password field
    # 4. it will cross verify with each other 'password' and 'confirm password', so it will add attribute accessor for password and 'password_confirmation' 
    # 5. Once cross verified it will encrypt password in a secure hash and will save it in our database.
    # 6. It gives use method name as 'authenticate', which convert the password into the same in the same way as it did initially to verify the user, it will return true if password is matched and false incase not.
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify
    validates(:email, presence: true, uniqueness: true, format:/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, unless: :from_oauth?)

    def from_oauth?
        uid.present? && provider.present?
    end
    def self.create_from_oauth(oauth_data)
        name=oauth_data["info"]["name"]&.split || oauth_data["info"]["nickname"]
        self.create(
            first_name:name[0],
            last_name:name[1] || "",
            uid: oauth_data["uid"],
            provider: oauth_data["provider"],
            oauth_raw_data: oauth_data,
            password: SecureRandom.hex(32)
        )

    end
    def self.find_by_oauth(oauth_data)
        self.find_by(
            uid: oauth_data["uid"],
            provider: oauth_data["provider"]
        )
    end

    # has_and_belongs_to_many(
    #     :liked_questions,
    #     class_name: 'Question',
    #     join_table: 'likes',
    #     association_foreign_key: 'question_id',
    #     foreign_key: 'user_id'
    # )
    has_many :likes
    has_many :liked_questions, through: :likes, source: :question


    def full_name
        "#{first_name} #{last_name}"
    end
end
