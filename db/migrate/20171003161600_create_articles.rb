class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.boolean :published
      t.integer :article_category_id

      t.string :name
      t.string :url_fragment
      t.text :content

      t.attachment :image
      t.date :release_date

      t.string :author_name
      t.string :author_description

      t.timestamps null: false
    end

    Article.create_translation_table(:name, :url_fragment, :author_name, :author_description, :content)
  end

  def down
    Article.drop_translation_table!

    drop_table :articles
  end
end
