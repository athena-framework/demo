@[ADI::Register(tags: [{name: ATHR::Interface::TAG, priority: 110}])]
struct Blog::Resolvers::Database
  include ATHR::Interface::Typed(Blog::Entities::Entity)

  configuration Entity

  def initialize(
    @entity_manager : Blog::Services::EntityManager,
  ); end

  # :inherit:
  def resolve(request : ATH::Request, parameter : ATH::Controller::ParameterMetadata(E)) : E? forall E
    {% if E < Blog::Entities::Entity %}
      return unless parameter.annotation_configurations.has? Entity

      id = request.attributes.get "id", Int64

      unless entity = @entity_manager.repository(E).find? id
        Log.context.set entity_class: E.name, id: id
        raise ATH::Exceptions::NotFound.new "An item with the provided ID could not be found."
      end

      entity
    {% end %}
  end
end

alias Blog::Entity = Blog::Resolvers::Database::Entity
