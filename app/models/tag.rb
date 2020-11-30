# rails g model tag name:string
# This model was generated via above terminal command, it also generated database migration
class Tag < ApplicationRecord
    has_many :taggings,dependent: :destroy
    has_many :questions,through: :taggings
end
