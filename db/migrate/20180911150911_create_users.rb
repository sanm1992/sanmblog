class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    	t.string   :name,                 :null => false,  :limit => 32     # 用户名
    	t.string   :password_digest,      :null => false				    # 密码
    	t.string   :email,                :null => true,   :limit => 32     # 邮箱
    	t.datetime :last_sign_time,       :null => true                     # 上次登陆时间
    	t.string   :authentication_token, :null => true                     # 验证token
    	t.integer  :sign_times,           :null => false, :default => 0  # 登陆次数
        t.boolean  :enabled,              :null => false, :default => true  # 状态

    	t.timestamps
    end
  end
end
