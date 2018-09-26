require 'mail'
class CustomMail
	class << self

	def send_mail(params)
		Mail.defaults do
			delivery_method :smtp, {
		    :port      => 25,
		    :address   => "smtpdm.aliyun.com",
		    :user_name => "sanmbog@sanm.site",
		    :password  => "HAOHAOxuexi123",
		    :enable_starttls_auto => false, 
		    :openssl_verify_mode => 'none',
		  }
		end
		
		mail = Mail.deliver do
		  to      params['email'] || '1320695403@qq.com'
		  from    'sanmbog@sanm.site'
		  subject params['subject'] || 'test'
		  text_part do
		    body params['content'].to_s
		  end
		end

		end
	end
end