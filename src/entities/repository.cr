abstract class Blog::Entities::Repository(E)
  def initialize(@database : DB::Database); end

  def find?(id : Int64) : E?
    @database.query_one?(%(SELECT * FROM "#{self.class.table_name}" WHERE "id" = $1 AND "deleted_at" IS NULL;), id, as: E)
  end

  def find_all : Array(E)
    @database.query_all %(SELECT * FROM "#{self.class.table_name}" WHERE "deleted_at" IS NULL;), as: E
  end
end
