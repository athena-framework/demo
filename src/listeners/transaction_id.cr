@[ADI::Register]
class Blog::Listeners::TransactionId
  include AED::EventListenerInterface

  def initialize(
    @transaction_id_store : Blog::Services::TransactionIdStore
  ); end

  @[AEDA::AsEventListener]
  def add_transaction_id(event : ATH::Events::Response) : Nil
    event.response.headers[Blog::Services::TransactionIdStore::HEADER_NAME] = @transaction_id_store.transaction_id
  end
end
