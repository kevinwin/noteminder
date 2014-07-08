class AddSrsUpdateToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :srs_update, :integer
  end
end
