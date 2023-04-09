module Blog::Entities::CreatedAtAware
  getter! created_at : Time

  @id : Int64?

  protected def before_save : Nil
    super

    if @id.nil?
      @created_at = Time.utc
    end
  end
end
