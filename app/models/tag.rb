# rails g model tag name:string
# This model was generated via above terminal command, it also generated database migration
class Tag < ApplicationRecord
    before_save :downcase_name
    has_many :taggings,dependent: :destroy
    has_many :questions,through: :taggings

    validates :name, presence: true,uniqueness:{case_sensitive: false}
    # SCEIENCES not equals to sciences
    # The case_sensitive option will make uniquness validation ignore case.
    # In table record with "SCIENCE" and 'Science' can't co-exsist
    private
    def downcase_name
        self.name&.downcase!
    end
end
