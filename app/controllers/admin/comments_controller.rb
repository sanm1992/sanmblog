class Admin::CommentsController < Admin::BaseController
	def index
		@article = Article.find_by(id: params['article_id'])
		@comments = @article.comments
	end

	def destroy
		@comment = Comment.find(params['id'])

		notice = @comment.update(enabled: false) ? '删除成功' : '删除失败'

		redirect_back(fallback_location: root_path, :notice => notice)
	end

	def message_list
		page = params[:page] || 1
		@messages = Comment.personal_letter.order(:created_at).page(page.to_i).per(10)
	end
end