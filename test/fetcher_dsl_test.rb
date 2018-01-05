require 'test_helper'

class FetcherDslTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FetcherDsl::VERSION
  end

  def test_it_does_something_useful
    @fetcher = FetcherDsl.define {
      name "acme"
    }
    assert_equal FetcherDsl::Fetcher, @fetcher.class
    assert_equal "acme", @fetcher.name
  end

  def test_it_sets_default_delay
    @fetcher = FetcherDsl.define {
      name "acme"
    }
    assert_equal FetcherDsl::Fetcher, @fetcher.class
    assert_equal 0, @fetcher.period
  end
end
