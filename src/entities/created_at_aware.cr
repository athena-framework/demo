module Blog::Entities::CreatedAtAware
  @[AORMA::Column]
  property! created_at : Time

  @[AORMA::PrePersist]
  def set_created_at : Nil
    @created_at = Time.utc
  end
end
