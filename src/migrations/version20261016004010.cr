class Blog::Migrations::Version20261016004010 < AORM::Migrations::AbstractMigration
  def description : String
    "Create the articles table"
  end

  def up : Nil
    self.add_sql <<-'SQL'
      CREATE TABLE IF NOT EXISTS "articles"
      (
          "id"         BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
          "title"      TEXT                                NOT NULL,
          "body"       TEXT                                NOT NULL,
          "created_at" TIMESTAMPTZ                         NOT NULL,
          "updated_at" TIMESTAMPTZ                         NOT NULL,
          "deleted_at" TIMESTAMPTZ                         NULL
      );
      SQL
  end

  def down : Nil
    self.add_sql %(DROP TABLE IF EXISTS "articles";)
  end
end
