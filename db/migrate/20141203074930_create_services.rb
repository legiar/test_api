class CreateServices < ActiveRecord::Migration

  def change
    create_table :services do |t|
      t.string      :type
      t.string      :name,    null: false
      t.boolean     :codes,   null: false, default: false
      t.boolean     :status,  null: false, default: false
      t.timestamps
    end
  end
end
