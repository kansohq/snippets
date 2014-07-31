class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets_snippets do |t|
      t.string :key
      t.text   :value

      t.timestamps
    end

    add_index :snippets_snippets, :key
  end
end
