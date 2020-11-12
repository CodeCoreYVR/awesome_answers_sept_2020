class ApplicationRecord < ActiveRecord::Base
# 👆🏻This Application record inherits from ActiveRecords
# ActiveRecord has all the methods that are used for communication with Database
  self.abstract_class = true
end
