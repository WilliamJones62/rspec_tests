# frozen_string_literal: true

class BattlesExtendedService
  def fight(battle)
    # the mosters have already been checked for presence
    @monsterA = Monster.find(battle.monsterA_id)
    @monsterB = Monster.find(battle.monsterB_id)
    if a_goes_first(@monsterA, @monsterB)
      battle.winner_id = rumble(@monsterA, @monsterB)
    else
      battle.winner_id = rumble(@monsterB, @monsterA)
    end
    battle
  end

  def a_goes_first(monsterA, monsterB)
    if monsterA.speed > monsterB.speed
      return true
    elsif monsterA.speed == monsterB.speed
      if monsterA.attack > monsterB.attack
        return true
      end
    end
    return false
  end

  def rumble(first_monster, second_monster)
    winner_not_found = true
    while winner_not_found do
      damage = calculate_damage(first_monster.attack, second_monster.defense) 
      second_monster.hp -= damage
      if second_monster.hp < 1
        winner_id = first_monster.id
        winner_not_found = false
      else
        # second monsters turn
        damage = calculate_damage(second_monster.attack, first_monster.defense) 
        first_monster.hp -= damage
        if first_monster.hp < 1
          winner_id = second_monster.id
          winner_not_found = false
        end
      end
    end
    winner_id
  end 
  
  def calculate_damage(attack, defense)
    damage = attack - defense
    if damage < 1
      damage = 1
    end
    damage
  end
end
