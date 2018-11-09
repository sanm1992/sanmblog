class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
    	t.string :name, null: false
    	t.text :oss_url, null: false
    	t.boolean :enabled, null: false, default: true
    	t.text :note
    	t.string :category, null: false, limit: 64, default: 'daily'
    	t.timestamps
    end
  end
end
