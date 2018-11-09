class Admin::PhotosController < Admin::BaseController
	def index
		page = params[:page] || 1
		@photos = Photo.page(page.to_i).per(10)
	end

	def edit

	end

	def new
		# options = AliyunOSS.options
		# @bucket_name = options[:bucket_name]
	 #  @prefix = options[:prefix]
	 #  @bucket = AliyunOSS.client.get_bucket(@bucket_name)
	  
	 #  @options = {
	 #    :prefix => @prefix,
	 #    :redirect => admin_photos_path
	 #  }
	end

	def create
		if params[:file].blank?
			redirect_back(fallback_location: root_path, :notice => '请选择需要上传的图片')
			return
		end

		options = AliyunOSS.options
		bucket = AliyunOSS.client.get_bucket(options[:bucket_name])
		bucket.put_object("#{options[:bucket_name]}/#{params[:file].original_filename}", :file => params[:file].tempfile)

		url = "http://sanm-blog.oss-cn-hongkong.aliyuncs.com/#{options[:bucket_name]}/" + params[:file].original_filename
		
		photo = Photo.new({oss_url: url, note: params[:note], category: params[:category], name: params[:file].original_filename})

		if photo.save
			redirect_to(admin_photos_path, notice: "创建成功")
		else
			render :action => "new"
		end
	end
end