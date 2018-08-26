class AddComments < ActiveRecord::Migration[5.2]
  def change
  	create_table :comments do |t|
  		t.string  :user_name, 	:null => false, :limit => 32
  		t.string  :email, 			:null => false, :limit => 32
  		t.text 	  :content, 		:null => false
  		t.integer :floor, 			:null => false, :default => 1, :limit => 4
  		t.boolean :enabled,   	:null => false, :default => true
  		t.integer :reply_to,    :null => true,  :limit => 4
  		t.timestamps
  	end
  	add_reference :comments, :article, foreign_key: true
  end
end
