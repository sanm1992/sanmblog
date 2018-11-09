class Admin::ArticlesController < Admin::BaseController
	def index
		page = params[:page] || 1
		@articles = Article.tec_articles.page(page.to_i).per(10)
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
	    redirect_to(admin_article_path(@article), notice: "更新成功")
	  else
	    render 'edit'
	  end
	end

	def destroy
		@article = Article.find(params['id'])

		notice = @article.update(enabled: false) ? '下架成功' : '下架失败'
		
		redirect_to(admin_articles_path, notice: notice)
	end

	def edit
		@article = Article.tec_articles.find(params[:id])
	end

	def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to(admin_article_path(@article), notice: "创建成功")
    else
      render :action => "new"
    end
	end

	def preview
    text = MyMarkdown.render_markdown(params["text"]) if params["text"].present?
    @markdown = {'text' => text || ''} 

  	respond_to do |format|
      format.json { render json: @markdown}
	  end
  end

  def set_enabled
  	article = Article.find_by(id: params[:id])
  	
  	notice = article.update(enabled: true) ? '上架成功' : '上架失败'

		redirect_to admin_articles_path, notice: notice
  end

	private

  def article_params
    params.require(:article).permit(:title, :content, :tag, :category, :attachment)
  end
end