class Client::CommentsController < Client::BaseController
	def create
		@comment = Comment.new(permit_params)
		if @comment.save(permit_params)
			redirect_back(fallback_location: root_path, notice: "评论成功")
		else
			redirect_back(fallback_location: root_path, notice: "评论失败")
		end
	end

	def index
		# render js: "$('#animations').append('<%= j render 'animation', animation: @animation %>')"
	end

	private

	def permit_params
    params.slice(:user_name, :email, :content, :floor, :reply_to, :article_id).as_json
  end

end