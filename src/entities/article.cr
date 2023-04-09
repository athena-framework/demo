class Blog::Entities::Article < Blog::Entities::Entity
  include JSON::Serializable
  include AVD::Validatable

  include CreatedAtAware
  include UpdatedAtAware
  include SoftDeletable

  def initialize(@title : String, @body : String); end

  @[Assert::NotBlank]
  property title : String

  @[Assert::NotBlank]
  property body : String
end
