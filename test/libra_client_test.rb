require "test_helper"

class LibraTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Libra::VERSION
  end

  def test_it_does_something_useful
  	arr = [47, 115, 101, 110, 116, 95, 101, 118, 101, 110, 116, 115, 95, 99, 111, 117, 110, 116, 47]
    assert_equal arr, "/sent_events_count/".chars.map{|x| x.ord} 
  end

	def test_events
	    address = "000000000000000000000000000000000000000000000000000000000a550c18"
	    c = Libra::Client.new("testnet")
	    events = c.get_latest_events_sent(address, 2)
	    assert_equal events.size , 2
	end

	def test_get_transaction
	    c = Libra::Client.new("testnet")
	    txn = c.get_transaction(1)
	    assert_equal true, txn.raw_txn_bytes.size > 0
	end

	def test_get_latest_transaction_version
	    c = Libra::Client.new("testnet")
	    ver = c.get_latest_transaction_version()
	    assert_equal true, ver > 0
	end

	def test_get_balance
	    address = "000000000000000000000000000000000000000000000000000000000a550c18"
	    c = Libra::Client.new("testnet")
	    balance = c.get_balance(address)
	    assert_equal true, balance > 0
	end

	def test_get_account_transaction
	    address = "000000000000000000000000000000000000000000000000000000000a550c18"
	    c = Libra::Client.new("testnet")
	    txn = c.get_account_transaction(address, 1, false)
	    assert_equal true, txn.signed_transaction.raw_txn_bytes.size > 0
	end





end
