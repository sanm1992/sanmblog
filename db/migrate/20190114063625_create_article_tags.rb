class CreateArticleTags < ActiveRecord::Migration[5.2]
  def change
    create_table :article_tags do |t|
    	t.string :name, limit: 64, null: false, comment: '名称'
    	t.string :code, limit: 64, null: false, comment: '英文简称'
    	t.boolean :enabled, null: false, default: true, comment: '有效状态'

    	t.timestamps
    end
  end
end
