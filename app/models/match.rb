class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  has_many :stats
  has_many :users, through: :stats
  belongs_to :first_innings, class_name: 'Inning'
  belongs_to :second_innings, class_name: 'Inning'
end
