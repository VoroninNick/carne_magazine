class ArticleCategory < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :name, :url_fragment

  scope :order_by_sorting_position, -> { order("sorting_position asc") }
  default_scope do
    order_by_sorting_position
  end

  has_many :articles

end
