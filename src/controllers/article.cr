@[ADI::Register]
class Blog::Controllers::ArticleController < ATH::Controller
  def initialize(
    @entity_manager : Blog::Services::EntityManager
  ); end

  @[ARTA::Post("/article")]
  def create_article(
    @[ATHR::RequestBody::Extract]
    article : Blog::Entities::Article
  ) : Blog::Entities::Article
    @entity_manager.persist article
    article
  end

  @[ARTA::Put("/article/{id}")]
  def update_article(
    @[Blog::Entity]
    article_entity : Blog::Entities::Article,

    @[ATHR::RequestBody::Extract]
    article : Blog::Entities::Article
  ) : Blog::Entities::Article
    article_entity.title = article.title
    article_entity.body = article.body

    @entity_manager.persist article_entity
    article_entity
  end

  @[ARTA::Get("/article/{id}")]
  def article(
    @[Blog::Entity]
    article : Blog::Entities::Article
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
    article : Blog::Entities::Article
  ) : Nil
    @entity_manager.remove article
  end
end
