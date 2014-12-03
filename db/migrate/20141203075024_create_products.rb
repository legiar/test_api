class CreateProducts < ActiveRecord::Migration

  def change
    create_table :products do |t|
      t.string      :title,     null: false
      t.references  :service
      t.timestamps
    end
  end
end
