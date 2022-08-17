require_relative "parser"
require "test/unit"

# Test class to test the Parser class
# and it's key functionalities
class TestParser < Test::Unit::TestCase
  def setup
    @log = "webserver.log"
  end

  def test_check_and_get_log_file
    assert_equal(File, Parser.new(@log).check_and_get_log_file(@log).class)
  end

  def test_get_total_page_views
    assert_not_nil(Parser.new(@log).get_total_page_views())
  end

  def test_get_total_page_unique_views
    assert_not_nil(Parser.new(@log).get_total_page_unique_views())
  end
end
