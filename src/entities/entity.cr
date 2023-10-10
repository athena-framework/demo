abstract class Blog::Entities::Entity
  include DB::Serializable

  getter! id : Int64

  protected def after_save(@id : Int64) : Nil; end

  protected def on_remove : Nil
  end

  protected def before_save : Nil
  end
end
