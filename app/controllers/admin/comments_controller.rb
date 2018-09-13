class Admin::CommentsController < Admin::BaseController
	def index
		@article = Article.find_by(id: params['article_id'])
		@comments = @article.comments
	end

	def destroy
		@comment = Comment.find(params['id'])
		if @comment.update(enabled: false)
			notice = '删除成功'
		else
			notice = '删除失败'
		end
		redirect_back(fallback_location: root_path, :notice => notice)
	end
end