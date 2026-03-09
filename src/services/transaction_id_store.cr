require "uuid"

@[ADI::Register]
class Blog::Services::TransactionIdStore
  HEADER_NAME = "x-transaction-id"

  @request_store : AHTTP::RequestStore

  setter transaction_id : String? = nil

  def initialize(
    @request_store : AHTTP::RequestStore,
  ); end

  def transaction_id : String
    if id = @transaction_id
      return id
    end

    @transaction_id = self.create_transaction_id @request_store.request
  end

  private def create_transaction_id(request : AHTTP::Request) : String
    if id = request.headers[HEADER_NAME]?
      return id
    end

    UUID.random.to_s
  end
end
