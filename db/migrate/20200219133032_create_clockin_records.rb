class CreateClockinRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :clockin_records do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :register_type
      t.datetime :register_date
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
