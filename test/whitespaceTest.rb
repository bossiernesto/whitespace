require "test/unit"
require "../lib/assembler"

class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @assembler=Assembler.new()

    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end


  def test_Assemble
    #Test to assemble some instructions and
    fail(NotImplementedError)
  end

  # Fake test
  def test_fail

    # To change this template use File | Settings | File Templates.
    fail(NotImplementedError)
  end
end