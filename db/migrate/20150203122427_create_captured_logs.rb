class CreateCapturedLogs < ActiveRecord::Migration
  def change
    create_table :captured_logs do |t|
      t.references :portal, index: true
      t.datetime :captured_at
      t.string :player
      t.string :team

      t.timestamps null: false
    end
    add_foreign_key :captured_logs, :portals
  end
end
