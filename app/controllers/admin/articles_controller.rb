class Admin::ArticlesController < Admin::BaseController
	def index
		@articles = Article.tec_articles
	end

	def show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def update
		@article = Article.find(params[:id])

	  if @article.update(article_params)
	    redirect_to(admin_article_path(@article), :notice => "更新成功")
	  else
	    render 'edit'
	  end
	end

	def delete
		@article = Article.find(params['id'])
		if @article.update(enabled: false)
			notice = '下架成功'
		else
			notice = '下架失败'
		end
		redirect_to(admin_article_path(@article), :notice => notice)
	end

	def edit
		@article = Article.tec_articles.find(params[:id])
	end

	def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to(admin_article_path(@article), :notice => "创建成功")
    else
      render :action => "new"
    end
	end

	private

  def article_params
    params.require(:article).permit(:title, :content, :tag, :category, :attachment)
  end
end