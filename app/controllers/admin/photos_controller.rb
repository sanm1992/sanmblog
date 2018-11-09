class Admin::PhotosController < Admin::BaseController
	def index
		
	end

	def edit

	end

	def new
		options = AliyunOSS.options
		@bucket_name = options[:bucket_name]
	  @prefix = options[:prefix]
	  @bucket = AliyunOSS.client.get_bucket(@bucket_name)
	  
	  @options = {
	    :prefix => @prefix,
	    :redirect => admin_photos_path
	  }
	end

	def create
		options = AliyunOSS.options
		bucket = AliyunOSS.client.get_bucket(options[:bucket_name])
		bucket.put_object("photos/#{params[:file].original_filename}", :file => params[:file].tempfile)

		url = 'http://sanm-blog.oss-cn-hongkong.aliyuncs.com/photos/' + params[:file].original_filename
		
	
	end
end