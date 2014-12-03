class CreateBonusCodes < ActiveRecord::Migration

  def change
    create_table :bonus_codes do |t|
      t.references  :product,   null: false
      t.string      :number
      t.boolean     :used,      null: false, default: false
      t.timestamps
    end
  end
end
