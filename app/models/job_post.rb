class JobPost < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true
    validates :min_salary, numericality: {greater_than_or_equal_to: 30_000}
end
