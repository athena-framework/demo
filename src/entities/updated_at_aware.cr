module Blog::Entities::UpdatedAtAware
  getter! updated_at : Time

  protected def before_save : Nil
    super

    @updated_at = Time.utc
  end
end
