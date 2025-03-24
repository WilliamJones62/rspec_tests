class Battle < ApplicationRecord
  belongs_to :monsterA, class_name: 'Monster'
  belongs_to :monsterB, class_name: 'Monster'
  belongs_to :winner, class_name: 'Monster'
end
