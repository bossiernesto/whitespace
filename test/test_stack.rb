require "test/unit"
require_relative "../lib/stack"

class StackWhitespaceTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @stack=WsStack.new
    @stack.push(5).push(45).push(4) #push some values to test accordingly
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
     #do nothing
  end

  def test_pop
    assert_equal(4,@stack.pop())
    assert_equal(2,@stack.count)
  end

  def test_swap
    temp=[5,4,45]
    @stack.swapTop
    assert_equal(temp,@stack.stack)
  end

  def test_popRelative
    assert_equal(5,@stack.popRelative(3))
    assert_equal(2,@stack.count)
    assert_equal([45,4],@stack.stack)
  end

  def test_look
    @stack.push(1)
    assert_equal(4,@stack.count)   #Stack is [5,45,4,1]
    assert_equal(45,@stack.look(3))
    assert_equal(4,@stack.count) #verify that the value wasn't popped out
  end

end