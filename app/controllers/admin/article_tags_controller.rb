class Admin::ArticleTagsController < Admin::BaseController
	def index
		page = params[:page] || 1
		@article_tags = Tag.page(page.to_i).per(10)
	end

	def new
		@article_tag = Tag.new
	end

	def create
		 @article_tag = Tag.new(article_tag_params)

    if @article_tag.save
      redirect_to(admin_article_tags_path, notice: "创建成功")
    else
      render :action => "new"
    end
	end

	def edit
		@article_tag = Tag.find(params[:id])
	end

	def update
		@article_tag = Tag.find(params[:id])

	  if @article_tag.update(article_tag_params)
	    redirect_to(admin_article_tag_path(@article_tag), notice: "更新成功")
	  else
	    render 'edit'
	  end
	end

	def destroy
		@article_tag = Tag.find(params['id'])

		notice = @article_tag.update(enabled: false) ? '删除成功' : '删除失败'
		
		redirect_to(admin_article_tag_path, notice: notice)
	end

	private

  def article_tag_params
    params.require(:tag).permit(:name, :code)
  end
end