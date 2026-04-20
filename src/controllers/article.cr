@[ADI::Register]
class Blog::Controllers::ArticleController < ATH::Controller
  def initialize(
    @entity_manager : Blog::Services::EntityManager,
    @hub : AMC::Hub::Interface,
    @discovery : Athena::MercureBundle::Discovery,
  ); end

  @[ARTA::Post("/article")]
  def create_article(
    request : AHTTP::Request,
    @[ATHA::MapRequestBody]
    article : Blog::Entities::Article,
  ) : Blog::Entities::Article
    @entity_manager.persist article

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

    @entity_manager.persist article_entity
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
    @entity_manager.repository(Blog::Entities::Article).find_all
  end

  @[ARTA::Delete("/article/{id}")]
  def delete_article(
    @[Blog::Entity]
    article : Blog::Entities::Article,
  ) : Nil
    @entity_manager.remove article
  end
end
