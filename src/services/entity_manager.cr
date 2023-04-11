@[ADI::Register]
class Blog::Services::EntityManager
  @@database : DB::Database = DB.open ENV["DATABASE_URL"]

  macro finished
    {% for entity in Blog::Entities::Entity.subclasses %}
      def repository(entity_class : {{entity.id}}.class) : {{entity.id}}::Repository
        @@{{entity.name.split("::").last.downcase.id}}_repository ||= {{entity.id}}::Repository.new @@database
      end
    {% end %}
  end

  def remove(entity : Blog::Entities::Entity) : Nil
    entity.on_remove
    self.update entity
  end

  def persist(entity : Blog::Entities::Entity) : Nil
    entity.before_save

    id = if entity.id?.nil?
           self.save entity
         else
           return self.update entity
         end

    entity.after_save id
  end

  private def save(entity : Blog::Entities::Article) : Int64
    @@database.scalar(
      %(INSERT INTO "articles" ("title", "body", "created_at", "updated_at", "deleted_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id";),
      entity.title,
      entity.body,
      entity.created_at,
      entity.updated_at,
      entity.deleted_at,
    ).as Int64
  end

  private def update(entity : Blog::Entities::Article) : Nil
    @@database.exec(
      %(UPDATE "articles" SET "title" = $1, "body" = $2, "updated_at" = $3, "deleted_at" = $4 WHERE "id" = $5;),
      entity.title,
      entity.body,
      entity.updated_at,
      entity.deleted_at,
      entity.id
    )
  end
end
