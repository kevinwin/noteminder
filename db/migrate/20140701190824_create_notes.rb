class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
    	t.text :question
    	t.text :answer
    	t.integer :deck_id
    	t.timestamps
    end
  end
end
