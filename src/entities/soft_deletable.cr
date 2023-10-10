module Blog::Entities::SoftDeletable
  getter deleted_at : Time?

  protected def on_remove : Nil
    super

    @deleted_at = Time.utc
  end
end
