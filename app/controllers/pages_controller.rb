class PagesController < ApplicationController

  def index
    @articles = Article.published.limit(8)
    set_page_metadata(:home)
    @main_banner_article = @articles.find(2)
    @main_banner_articles = Article.limit(4)
    @issue_date = @articles.first.release_date
    @featured_articles = Article.published.order("id desc").limit(3)
    @article1 = @featured_articles[0]
    @article2 = @featured_articles[1]
    @article3 = Article.find(5)
  end

end