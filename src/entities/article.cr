@[AORMA::Entity]
@[AORMA::Table(name: "articles")]
class Blog::Entities::Article < AORM::Entity
  include JSON::Serializable
  include AVD::Validatable

  include CreatedAtAware
  include UpdatedAtAware
  include SoftDeletable

  def initialize(@title : String, @body : String); end

  @[AORMA::Column]
  @[AORMA::ID]
  @[AORMA::GeneratedValue]
  property! id : Int64

  @[AORMA::Column]
  @[Assert::NotBlank]
  property title : String

  @[AORMA::Column]
  @[Assert::NotBlank]
  property body : String
end
