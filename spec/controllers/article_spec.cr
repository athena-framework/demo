require "../spec_helper"

struct ArticleControllerTest < ATH::Spec::APITestCase
  def test_get_article : Nil
    DATABASE.exec <<-SQL
      INSERT INTO "articles" (id, title, body, created_at, updated_at) OVERRIDING SYSTEM VALUE
      VALUES (10, 'TITLE', 'BODY', timezone('utc', now()), timezone('utc', now()));
    SQL

    response = self.get "/article/10"

    response.status.should eq HTTP::Status::OK

    article = JSON.parse response.body
    article["title"].as_s.should eq "TITLE"
    article["body"].as_s.should eq "BODY"
  end

  def test_post_article : Nil
    response = self.post "/article", body: %({"title":"TITLE","body":"BODY"})

    article = JSON.parse response.body
    article["title"].as_s.should eq "TITLE"
    article["body"].as_s.should eq "BODY"
    article["created_at"].as_s?.should_not be_nil
    article["id"].raw.should be_a Int64
  end

  def ftest_update_article : Nil
    DATABASE.exec <<-SQL
      INSERT INTO "articles" (id, title, body, created_at, updated_at) OVERRIDING SYSTEM VALUE
      VALUES (10, 'TITLE', 'BODY', timezone('utc', now()), timezone('utc', now()));
    SQL

    entity = DATABASE.query_one %(SELECT * FROM "articles" WHERE "id" = $1), 10, as: Blog::Entities::Article
    entity.title.should eq "TITLE"
    entity.body.should eq "BODY"

    self.put "/article/10", body: %({"title":"NEW_TITLE","body":"NEW_BODY"})

    self.assert_response_is_successful

    entity = DATABASE.query_one %(SELECT * FROM "articles" WHERE "id" = $1), 10, as: Blog::Entities::Article
    entity.title.should eq "NEW_TITLE"
    entity.body.should eq "NEW_BODY"
  end

  def test_delete_article : Nil
    DATABASE.exec <<-SQL
      INSERT INTO "articles" (id, title, body, created_at, updated_at) OVERRIDING SYSTEM VALUE
      VALUES (10, 'TITLE', 'BODY', timezone('utc', now()), timezone('utc', now()));
    SQL

    entity = DATABASE.query_one %(SELECT * FROM "articles" WHERE "id" = $1), 10, as: Blog::Entities::Article
    entity.deleted_at.should be_nil

    self.delete "/article/10"

    self.assert_response_is_successful

    entity = DATABASE.query_one %(SELECT * FROM "articles" WHERE "id" = $1), 10, as: Blog::Entities::Article
    entity.deleted_at.should_not be_nil

    self.get "/article/10"

    self.assert_response_has_status :not_found
  end
end
