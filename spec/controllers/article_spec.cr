require "../spec_helper"

struct ArticleControllerTest < ATH::Spec::APITestCase
  include AORM::Spec::DatabaseTransaction

  def test_get_article : Nil
    article = Blog::Entities::Article.new "TITLE", "BODY"
    self.em.persist article
    self.em.flush

    response = self.get "/article/#{article.id}"

    response.status.should eq HTTP::Status::OK

    article = JSON.parse response.body
    article["title"].as_s.should eq "TITLE"
    article["body"].as_s.should eq "BODY"
  end

  def test_post_article : Nil
    response = self.post "/article", body: %({"title":"TITLE","body":"BODY"}), headers: HTTP::Headers{"content-type" => "application/json"}

    self.assert_response_is_successful

    article = JSON.parse response.body
    article["title"].as_s.should eq "TITLE"
    article["body"].as_s.should eq "BODY"
    article["created_at"].as_s?.should_not be_nil
    article["id"].raw.should be_a Int64
  end

  def test_update_article : Nil
    article = Blog::Entities::Article.new "TITLE", "BODY"
    self.em.persist article
    self.em.flush

    entity = self.em.find! Blog::Entities::Article, article.id
    entity.title.should eq "TITLE"
    entity.body.should eq "BODY"

    self.put "/article/#{article.id}", body: %({"title":"NEW_TITLE","body":"NEW_BODY"}), headers: HTTP::Headers{"content-type" => "application/json"}

    self.assert_response_is_successful

    entity = self.em.find! Blog::Entities::Article, article.id
    entity.title.should eq "NEW_TITLE"
    entity.body.should eq "NEW_BODY"
  end

  def test_delete_article : Nil
    article = Blog::Entities::Article.new "TITLE", "BODY"
    self.em.persist article
    self.em.flush

    entity = self.em.find! Blog::Entities::Article, article.id
    entity.deleted_at.should be_nil

    self.delete "/article/#{article.id}"

    self.assert_response_is_successful

    entity = self.em.find! Blog::Entities::Article, article.id
    entity.deleted_at.should_not be_nil

    self.get "/article/#{article.id}"

    self.assert_response_has_status :not_found
  end
end
