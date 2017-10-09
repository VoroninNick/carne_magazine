class Article < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :article_category

  globalize :name, :url_fragment, :author_name, :author_description, :content

  boolean_scope :published
  scope :order_by_release_date, -> { order("release_date desc") }

  default_scope do
    order_by_release_date
  end

  has_seo_tags
  has_sitemap_record

  def self.default_priority
    0.6
  end

  has_cache do
    pages :home, self, Article.published
  end

  image :image, styles: {default: "1920x860>", large_square: "450x450#", small_square: "225x225#", tall: "225x460#"}

  define_resource_methods :get, :url, :formatted_release_date

  def self.base_url(locale = I18n.locale)
    Cms.url_helpers.send("articles_#{locale}_path") rescue Cms.url_helpers.send("articles_path")
  end

  before_save :init_release_date
  def init_release_date
    self.release_date = self.created_at if self.release_date.blank?
  end

  def category
    article_category
  end

  def frame_video_url
    ApplicationHelper.frame_video_url(self)
  end

  def video_url
    ApplicationHelper.video_url(self)
  end

  def youtube_video_id
    "X9p56wSzsPA"
  end
end
