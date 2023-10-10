require "../spec_helper"

struct TransactionIdStoreSpec < ASPEC::TestCase
  @request_store : ATH::RequestStore
  @transaction_id_store : Blog::Services::TransactionIdStore

  def initialize
    @request_store = ATH::RequestStore.new
    @transaction_id_store = Blog::Services::TransactionIdStore.new @request_store
  end

  def test_transaction_id_from_header : Nil
    request = ATH::Request.new("GET", "/", headers: HTTP::Headers{"x-transaction-id" => "FOO"})

    @request_store.request = request

    @transaction_id_store.transaction_id.should eq "FOO"
  end

  def test_transaction_id_from_scratch : Nil
    request = ATH::Request.new("GET", "/")

    @request_store.request = request

    UUID.parse?(@transaction_id_store.transaction_id).should_not be_nil
  end
end
