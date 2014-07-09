class AddSrsAttributesToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :easiness_factor, :float
    add_column :notes, :number_repetitions, :integer
    add_column :notes, :quality_of_last_recall, :integer
    add_column :notes, :next_repetition, :date
    add_column :notes, :repetition_interval, :integer
    add_column :notes, :last_studied, :date
  end
end
