module Blog::Entities::SoftDeletable
  @[AORMA::Column]
  property deleted_at : Time?
end
