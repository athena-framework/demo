@[ADI::Register]
class Blog::Controllers::ArticleController < ATH::Controller
  def initialize(
    @em : AORM::EntityManagerInterface,
    @hub : AMC::Hub::Interface,
    @discovery : AMC::Bundle::Discovery,
  ); end

  @[ARTA::Post("/article")]
  def create_article(
    request : AHTTP::Request,
    @[ATHA::MapRequestBody]
    article : Blog::Entities::Article,
  ) : Blog::Entities::Article
    @em.persist article
    @em.flush

    @discovery.add_link request
    @hub.publish AMC::Update.new(
      "https://example.com/articles/#{article.id}",
      {id: article.id, title: article.title}.to_json,
    )

    article
  end

  @[ARTA::Put("/article/{id}")]
  def update_article(
    @[Blog::Entity]
    article_entity : Blog::Entities::Article,

    @[ATHA::MapRequestBody]
    article : Blog::Entities::Article,
  ) : Blog::Entities::Article
    article_entity.title = article.title
    article_entity.body = article.body

    @em.persist article_entity
    @em.flush
    article_entity
  end

  @[ARTA::Get("/article/{id}")]
  def article(
    @[Blog::Entity]
    article : Blog::Entities::Article,
  ) : Blog::Entities::Article
    article
  end

  @[ARTA::Get("/article")]
  def articles : Array(Blog::Entities::Article)
    @em.repository(Blog::Entities::Article).find_by deleted_at: nil
  end

  @[ARTA::Delete("/article/{id}")]
  def delete_article(
    @[Blog::Entity]
    article : Blog::Entities::Article,
  ) : Nil
    article.deleted_at = Time.utc
    @em.flush
  end
end
