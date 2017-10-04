class PagesController < ApplicationController

  def index
    @articles = Article.published.limit(8)
    set_page_metadata(:home)
    @main_banner_article = @articles.find(2)
    @main_banner_articles = Article.limit(4)
  end

end