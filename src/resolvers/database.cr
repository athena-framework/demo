@[ADI::Register(tags: [{name: ATHR::Interface::TAG, priority: 110}])]
struct Blog::Resolvers::Database
  include ATHR::Interface::Typed(AORM::Entity)

  configuration ::Blog::Resolvers::Database::Entity

  def initialize(
    @em : AORM::EntityManagerInterface,
    @annotation_resolver : ATH::AnnotationResolver,
  ); end

  # :inherit:
  def resolve(request : AHTTP::Request, parameter : AHK::Controller::ParameterMetadata(E)) : E? forall E
    {% if E < AORM::Entity %}
      return unless @annotation_resolver.action_parameter_annotations(request, parameter.name).has? Entity

      id = request.attributes.get "id", Int64

      unless entity = @em.repository(E).find_one_by id: id, deleted_at: nil
        Log.context.set entity_class: E.name, id: id
        raise AHK::Exception::NotFound.new "An item with the provided ID could not be found."
      end

      entity
    {% end %}
  end
end

alias Blog::Entity = Blog::Resolvers::Database::Entity
