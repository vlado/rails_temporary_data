class CreateTemporaryData < ActiveRecord::Migration[5.0]
  def change
    create_table :temporary_data do |t|
      t.text :data
      t.datetime :expires_at

      t.timestamps
    end
  end
end
