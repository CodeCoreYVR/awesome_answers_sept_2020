# rails g model tagging question:references tag:references
# This model is generated via above command and it also generated respective migration for db

class Tagging < ApplicationRecord
  belongs_to :question
  belongs_to :tag
end
