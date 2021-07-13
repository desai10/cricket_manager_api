class Inning < ApplicationRecord
  has_many :deliveries
  belongs_to :team
  belongs_to :strike_batsman, class_name: 'User'
  belongs_to :non_strike_batsman, class_name: 'User'
  belongs_to :bowler, class_name: 'User'
end
