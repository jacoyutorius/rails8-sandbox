class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.datetime :published_at
      t.text :sender
      t.text :content

      t.timestamps
    end
  end
end
