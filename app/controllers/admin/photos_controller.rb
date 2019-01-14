class Admin::PhotosController < Admin::BaseController
	def index
		page = params[:page] || 1
		@photos = Photo.page(page.to_i).per(10)
	end

	def edit
		@photo = Photo.find(params[:id])
	end

	def new
		@photo = Photo.new
	end

	def create
		photo = params[:photo]
		if photo[:file].blank?
			redirect_back(fallback_location: root_path, :notice => '请选择需要上传的图片')
			return
		end

		options = AliyunOSS.options
		bucket = AliyunOSS.client.get_bucket(options[:bucket_name])
		bucket.put_object("#{options[:bucket_name]}/#{photo[:file].original_filename}", :file => photo[:file].tempfile)

		url = "http://sanm-blog.oss-cn-hongkong.aliyuncs.com/#{options[:bucket_name]}/" + photo[:file].original_filename
		
		photo = Photo.new({oss_url: url, note: photo[:note], category: photo[:category], name: photo[:file].original_filename})

		if photo.save
			redirect_to(admin_photos_path, notice: "创建成功")
		else
			render :action => "new"
		end
	end

	def set_enabled
		photo = Photo.find(params[:photo_id])
		photo.enabled = true
		if photo.save
			redirect_to(admin_photos_path, notice: '展示成功')
		else
			redirect_back(fallback_location: root_path, notice: '展示失败')
		end
	end

	def destroy
		photo = Photo.find(params['id'])

		notice = photo.update(enabled: false) ? '下架成功' : '下架失败'
		
		redirect_to(admin_photos_path, notice: notice)
	end

	def delete
		photo = Photo.find(params[:photo_id])
		if photo.destroy
			notice = '删除成功'
		else
			notice = '删除失败'
		end
		redirect_to(admin_photos_path, notice: notice)
	end
end