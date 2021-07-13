class Delivery < ApplicationRecord
  belongs_to :inning
  belongs_to :bowler, class_name: 'User'
  belongs_to :batsman, class_name: 'User'
  belongs_to :helped_by, class_name: 'User'
end
