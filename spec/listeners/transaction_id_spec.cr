require "../spec_helper"

struct TransactionIdListenerTest < ASPEC::TestCase
  @transaction_id_listener : Blog::Listeners::TransactionId

  def initialize
    transaction_id_store = Blog::Services::TransactionIdStore.new AHTTP::RequestStore.new
    transaction_id_store.transaction_id = "UUID"

    @transaction_id_listener = Blog::Listeners::TransactionId.new transaction_id_store
  end

  def test_add_transaction_id : Nil
    event = AHK::Events::Response.new(
      AHTTP::Request.new("GET", "/"),
      response = AHTTP::Response.new
    )

    response.headers["x-transaction-id"]?.should be_nil

    @transaction_id_listener.add_transaction_id event

    response.headers["x-transaction-id"]?.should eq "UUID"
  end
end
