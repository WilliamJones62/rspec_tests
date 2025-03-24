class Monster < ApplicationRecord
  has_many :monsterA_battle, class_name: 'Battle', foreign_key: 'monsterA_id'
  has_many :monsterB_battle, class_name: 'Battle', foreign_key: 'monsterB_id'
  has_many :winner_battle, class_name: 'Battle', foreign_key: 'winner_id'

  validates :name, presence: true
  validates :attack, presence: true
  validates :defense, presence: true
  validates :hp, presence: true
  validates :speed, presence: true
  validates :imageUrl, presence: true
end
