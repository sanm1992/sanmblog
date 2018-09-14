require 'mail'
class CustomMail
	class << self
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

		def send_mail(params)
			mail = Mail.deliver do
			  to      params['email']
			  from    'sanmbog@sanm.site'
			  subject params['subject']
			  text_part do
			    body params['content'].to_s
			  end
			end

		end
	end
end