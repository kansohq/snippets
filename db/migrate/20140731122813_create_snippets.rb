class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :key
      t.text   :value

      t.timestamps
    end

    add_index :snippets, :key
  end
end
