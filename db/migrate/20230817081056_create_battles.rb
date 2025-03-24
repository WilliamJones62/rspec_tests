class CreateBattles < ActiveRecord::Migration[7.0]
  def change
    create_table :battles do |t|
      t.references :monsterA #, null: false, foreign_key: true
      t.references :monsterB
      t.references :winner

      t.timestamps
    end
  end
end
