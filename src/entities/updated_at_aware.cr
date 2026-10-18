module Blog::Entities::UpdatedAtAware
  @[AORMA::Column]
  property! updated_at : Time

  @[AORMA::PreUpdate]
  @[AORMA::PrePersist]
  def set_updated_at : Nil
    @updated_at = Time.utc
  end
end
