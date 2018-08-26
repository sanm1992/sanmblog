class AddArticles < ActiveRecord::Migration[5.2]
  def change
  	create_table :articles do |t|
  		t.string 	:tag,    					:null => true,  :limit => 32  		# 标签
  		t.string 	:title,  					:null => false                		# 标题
  		t.text   	:content,					:null => false                		# 文章能容
  		t.integer	:reading_time, 		:null => false, :default => 0 		# 浏览次数
  		t.string 	:category,      	:bull => false, :default => 'tec'	# 类型[技术类，日记类]
  		t.text   	:attachment, 			:null => true                 		# 附件
      t.boolean :enabled,         :null => false, :default => true

  		t.timestamps
  	end
  end
end
