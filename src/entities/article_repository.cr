class Blog::Entities::Article::Repository < Blog::Entities::Repository(Blog::Entities::Article)
  def self.table_name : String
    "articles"
  end
end
