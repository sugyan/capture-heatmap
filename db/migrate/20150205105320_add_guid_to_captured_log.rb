class AddGuidToCapturedLog < ActiveRecord::Migration
  def change
    add_column :captured_logs, :guid, :string
    add_index :captured_logs, :guid, unique: true
  end
end
